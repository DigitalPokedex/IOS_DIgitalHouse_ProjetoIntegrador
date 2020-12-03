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
    @IBAction func saveButtonAction(_ sender: Any) {
        let tabbar = TabBarController.shared
        navigationController?.pushViewController(tabbar, animated: true)
    }
    var favoritesList = [Pokemon]()
    var allPokemonList = [Pokemon]()
    var filteredPokemonList = [Pokemon]()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        searchTextField.delegate = self
        self.hideKeyboardWhenTappedAround()
        searchWrapper.layer.cornerRadius = 10
        loadDataPokemon()
        loadDataFavorites()
        collectionView.reloadData()
    }
    
    @IBAction func previousScreenAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func filterElementsById(list: [Pokemon], element: Pokemon) -> [Pokemon] {
        return list.filter(){$0.id != element.id}
    }
    
    func sortElementsById(_ list: [Pokemon]) -> [Pokemon] {
        let sortedElements = list.sorted {
            $0.id < $1.id
        }
        return sortedElements
    }
    
    func removeFavorites() -> [Pokemon] {
        var pokemonListWithoutFavorites = [Pokemon]()
        for favorite in favoritesList {
            pokemonListWithoutFavorites = filterElementsById(list: allPokemonList, element: favorite)
        }
        return pokemonListWithoutFavorites
    }
    
    func loadDataFavorites() {
        favoritesList.append(Pokemon(image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png", name: "Bulbasaur", id: 1, types: ["Grass", "Poison"]))
        favoritesList.append(Pokemon(image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/6.png", name: "Charizard", id: 6, types: ["Fire", "Flying"]))
        favoritesList.append(Pokemon(image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/150.png", name: "Mewtwo", id: 150, types: ["Psychic"]))
        favoritesList.append(Pokemon(image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/249.png", name: "Lugia", id: 249, types: ["Psychic", "Flying"]))

        for favorite in favoritesList {
            allPokemonList = filterElementsById(list: allPokemonList, element: favorite)
            filteredPokemonList = allPokemonList
        }
    }
    
    func loadDataPokemon() {
        allPokemonList.append(Pokemon(image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png", name: "Bulbasaur", id: 1, types: ["Grass", "Poison"]))
        allPokemonList.append(Pokemon(image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/2.png", name: "Ivysaur", id: 2, types: ["Grass", "Poison"]))
        allPokemonList.append(Pokemon(image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/3.png", name: "Venusaur", id: 3, types: ["Grass", "Poison"]))
        allPokemonList.append(Pokemon(image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png", name: "Charmander", id: 4, types: ["Fire"]))
        allPokemonList.append(Pokemon(image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/5.png", name: "Charmeleon", id: 5, types: ["Fire"]))
        allPokemonList.append(Pokemon(image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/6.png", name: "Charizard", id: 6, types: ["Fire", "Flying"]))
        allPokemonList.append(Pokemon(image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png", name: "Squirtle", id: 7, types: ["Water"]))
        allPokemonList.append(Pokemon(image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/8.png", name: "Wartotle", id: 8, types: ["Water"]))
        allPokemonList.append(Pokemon(image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/150.png", name: "Mewtwo", id: 150, types: ["Psychic"]))
        allPokemonList.append(Pokemon(image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/249.png", name: "Lugia", id: 249, types: ["Psychic", "Flying"]))
        filteredPokemonList = allPokemonList
    }
    
    func contains(element: Pokemon, list: [Pokemon]) -> Bool {
        let results = list.filter { arrayElement in arrayElement.id == element.id }
        return results.count > 0
    }
}

extension InitialFavoritesRegistrationViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(favoritesList[indexPath.row].name)
    }
}

extension InitialFavoritesRegistrationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectionViewCell", for: indexPath) as! FavoriteCollectionViewCell
        cell.setup(pokemon: favoritesList[indexPath.row])
        cell.remove{ (pokemon) in
            self.favoritesList = self.filterElementsById(list: self.favoritesList, element: pokemon)
            self.collectionView.reloadData()
            self.filteredPokemonList.append(pokemon)
            //self.searchTextField.text! = ""
            self.filteredPokemonList = self.sortElementsById(self.filteredPokemonList)
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

extension InitialFavoritesRegistrationViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print(searchTextField.text!)
        filteredPokemonList = [Pokemon]()
        let filterQuery = searchTextField.text!
        if !searchTextField.text!.isEmpty {
            filteredPokemonList = removeFavorites().filter { (pokemon) -> Bool in
                print("aqui")
                return pokemon.name.lowercased().contains(filterQuery.lowercased())
            }
        } else {
            filteredPokemonList.append(contentsOf: removeFavorites())
        }
        collectionView.reloadData()
        tableView.reloadData()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

extension InitialFavoritesRegistrationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonTableViewCell") as! PokemonTableViewCell
        cell.setup(pokemon: filteredPokemonList[indexPath.row])
        cell.add{ (pokemon) in
            self.filteredPokemonList = self.filterElementsById(list: self.filteredPokemonList, element: pokemon)
            self.tableView.reloadData()
            //self.searchTextField.text! = ""
            self.favoritesList.append(pokemon)
            self.favoritesList = self.sortElementsById(self.favoritesList)
            self.collectionView.reloadData()
        }
        return cell
    }
}
