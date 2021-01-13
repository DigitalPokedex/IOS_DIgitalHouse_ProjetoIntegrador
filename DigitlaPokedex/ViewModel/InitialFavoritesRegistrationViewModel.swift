//
//  InitialFavoritesRegistrationViewModel.swift
//  DigitlaPokedex
//
//  Created by Jorge Carvalho on 05/01/21.
//

import Foundation
import UIKit

class InitialFavoritesRegistrationViewModel {
    private var navigationController: UINavigationController!
    private var tableView: UITableView!
    var pokemonAPI = PokemonAPI()
    var pokemonNumber = 1
    var allSimplePokemonData: [PokemonSimpleData]?
    var favoritesList = [3, 6, 9]
    var listWithCompleteData = [Pokemon]()
    
    var filterArray = [Pokemon]()
    
    func configureViewModel(tableView: UITableView!, navigationController: UINavigationController!) {
        self.tableView = tableView
        self.navigationController = navigationController
    }
    
    func sortNumbers(_ list: [Int]) -> [Int] {
        let sortedElements = list.sorted {
            $0 < $1
        }
        return sortedElements
    }
    
    func removeFavorite(id: Int) {
        let filteredList = favoritesList.filter { favorite in favorite != id }
        self.favoritesList = filteredList
    }
    
    func isFavorite(element: Pokemon) -> Bool {
        let results = favoritesList.filter { arrayElement in arrayElement == element.id }
        return results.count > 0
    }
    
//    func sortElementsById(_ list: [Pokemon]) -> [Pokemon] {
//        let sortedElements = list.sorted {
//            $0.id < $1.id
//        }
//        return sortedElements
//    }
    
//    func filterArray(searchQuery: String) {
//        filterArray = [Pokemon]()
//        if !searchQuery.isEmpty {
//            filterArray = listWithCompleteData.filter { (element) -> Bool in
//                element.getName().contains(searchQuery.lowercased())
//            }
//        } else {
//            filterArray.append(contentsOf: listWithCompleteData)
//        }
//    }
    
    func filterByName(searchQuery: String) {
        let filterArray = allSimplePokemonData!.filterByName(searchQuery)
        print("  ")
        for index in 0...(filterArray.count - 1) {
            print("\(index) - \(filterArray[index].name!)")
        }
    }
    
    func loadSimplePokemonList(onComplete: @escaping (Bool) -> Void) {
        pokemonAPI.getAllPokemonSimpleData { (allSimplePokemonData, success) in
            self.allSimplePokemonData = allSimplePokemonData
            self.loadListWithCompleteData(onComplete: { (listWithCompleteData, success) in
                onComplete(success)
            })
        }
    }
    func loadListWithCompleteData(onComplete: @escaping ([Pokemon]?, Bool) -> Void) {
        pokemonAPI.getListWithCompleteData { (listWithCompleteData, success) in
            if(listWithCompleteData != nil) {
                self.listWithCompleteData.append(contentsOf: listWithCompleteData!.sortElementsById())
                self.filterArray = self.listWithCompleteData
//                self.loadListWithCompleteData(onComplete: { (listWithCompleteData, success)  in
//                    self.tableView.reloadData()
//                })
                onComplete(listWithCompleteData, success)
            }
        }
    }
    
    func getTableCustomCell(tableView: UITableView, collectionView: UICollectionView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonTableViewCell") as! PokemonTableViewCell
        cell.setup(pokemon: filterArray[indexPath.row])
        cell.add{ (pokemon) in
            tableView.reloadData()
            self.favoritesList.append(pokemon.id)
            self.favoritesList = self.sortNumbers(self.favoritesList)
            collectionView.reloadData()
        }
        return cell
    }
    
    func getCellHeight(tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        if(isFavorite(element: filterArray[indexPath.row])) {
            return 0
        }
        
        return tableView.rowHeight
    }
    
    func getNumberOfTableViewCells(tableView: UITableView) -> Int {
        return filterArray.count
    }
    
    
    func getNumberOfCollectionViewCells(collectionView: UICollectionView) -> Int {
        return self.favoritesList.count
    }
    
    func getCollectionCustomCell(tableView: UITableView, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectionViewCell", for: indexPath) as! FavoriteCollectionViewCell
        if(self.listWithCompleteData.count > 0) {
            cell.setup(pokemon: self.listWithCompleteData[self.favoritesList[indexPath.row] - 1])
        }
        cell.remove{ (pokemon) in
            self.removeFavorite(id: pokemon.id!)
            collectionView.reloadData()
            tableView.reloadData()
        }
        
        return cell
    }
    
    func toPreviousScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    func toHomeScreen() {
        let tabbar = TabBarController.shared
        navigationController?.pushViewController(tabbar, animated: true)
    }
}