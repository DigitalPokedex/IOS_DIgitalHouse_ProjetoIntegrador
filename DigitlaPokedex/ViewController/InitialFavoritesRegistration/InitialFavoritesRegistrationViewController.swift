//
//  InitialFavoritesRegistrationViewController.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 23/11/20.
//

import UIKit

class InitialFavoritesRegistrationViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchWrapper: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var viewModel = InitialFavoritesRegistrationViewModel()
    
    var favoritesList = [3, 6, 9]
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        self.hideKeyboardWhenTappedAround()
        searchWrapper.layer.cornerRadius = 10
        collectionView.reloadData()
        
        loadInitialData()
    }
    
    func loadInitialData() {
        viewModel.loadSimplePokemonList(onComplete: { (success) in
            if(success) {
                self.tableView.reloadData()
                self.collectionView.reloadData()
            }
            
        })
    }
    
    func filterElementsById(list: [PokemonTemp2], element: PokemonTemp2) -> [PokemonTemp2] {
        return list.filter(){$0.id != element.id}
    }
    
    func sortElementsById(_ list: [Int]) -> [Int] {
        let sortedElements = list.sorted {
            $0 < $1
        }
        return sortedElements
    }
    
    func removeFavorite(id: Int) {
        let filteredList = favoritesList.filter { favorite in favorite != id }
        self.favoritesList = filteredList
    }

    
    func contains(element: PokemonTemp2, list: [PokemonTemp2]) -> Bool {
        let results = list.filter { arrayElement in arrayElement.id == element.id }
        return results.count > 0
    }
    
    func isFavorite(element: Pokemon) -> Bool {
        let results = favoritesList.filter { arrayElement in arrayElement == element.id }
        return results.count > 0
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        viewModel.saveFavorites()
    }
    
    @IBAction func previousScreenAction(_ sender: Any) {
        viewModel.toPreviousScreen()
    }
}

extension InitialFavoritesRegistrationViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print(favoritesList[indexPath.row].name)
    }
}

extension InitialFavoritesRegistrationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectionViewCell", for: indexPath) as! FavoriteCollectionViewCell
        if(viewModel.listWithCompleteData.count > 0) {
            cell.setup(pokemon: viewModel.listWithCompleteData[favoritesList[indexPath.row] - 1])
        }
        cell.remove{ (pokemon) in
            self.removeFavorite(id: pokemon.id!)
            self.collectionView.reloadData()
            self.tableView.reloadData()
        }
        return cell
    }
    
    
}

extension InitialFavoritesRegistrationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension InitialFavoritesRegistrationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listWithCompleteData.count
    }
    
    func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(isFavorite(element: viewModel.listWithCompleteData[indexPath.row])) {
            return 0
        }
            
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonTableViewCell") as! PokemonTableViewCell
        
        cell.setup(pokemon: viewModel.listWithCompleteData[indexPath.row])
        cell.add{ (pokemon) in
            self.tableView.reloadData()
            self.favoritesList.append(pokemon.id)
            self.favoritesList = self.sortElementsById(self.favoritesList)
            self.collectionView.reloadData()
        }
        return cell
    }
}
