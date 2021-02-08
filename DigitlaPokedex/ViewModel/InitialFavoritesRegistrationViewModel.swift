//
//  InitialFavoritesRegistrationViewModel.swift
//  DigitlaPokedex
//
//  Created by Jorge Carvalho on 05/01/21.
//

import Foundation
import UIKit
import Firebase
import UIScrollView_InfiniteScroll
import Realm
import RealmSwift


class InitialFavoritesRegistrationViewModel: DefaultViewModelProtocol {
    private var navigationController: UINavigationController!
    private var tableView: UITableView!
    private var collectionView: UICollectionView!
    var pokemonAPI = PokemonAPI()
    var pokemonNumber = 1
    var allSimplePokemonData: [PokemonSimpleData]?
    //var favoritesList = [Pokemon]()
    var listWithCompleteData = [Pokemon]()
    
    var filterArray = [Pokemon]()
    
    func returnListWithCompleteData() -> [Pokemon] {
        return listWithCompleteData
    }
    
    func reloadData() {
        self.tableView.reloadData()
        
        self.collectionView.reloadData()
    }
    
    func configureViewModel(tableView: UITableView!, navigationController: UINavigationController!, collectionView: UICollectionView!) {
        self.navigationController = navigationController
        
        self.tableView = tableView
        self.collectionView = collectionView
        tableView.addInfiniteScroll { (tableView) -> Void in
            self.loadListWithCompleteData(onComplete: { (listWithCompleteData, success) in
                tableView.finishInfiniteScroll()
            })
        }
    }
    
    func sortNumbers(_ list: [Int]) -> [Int] {
        let sortedElements = list.sorted {
            $0 < $1
        }
        return sortedElements
    }
    
    func removeFavorite(withId: Int) {
        let realm = try! Realm()
        try! realm.write {
            let dataRealm = realm.objects(DataRealm.self)
            let objectsToDelete = realm.objects(CompletePokemonRealm.self).filter("id == \(withId)")
            realm.delete(objectsToDelete)
        }
    }
    
    func returnFavorites() -> List<CompletePokemonRealm> {
        let realm = try! Realm()
        let dataRealm = realm.objects(DataRealm.self)
        return dataRealm.count > 0 ? dataRealm[0].favorites : List<CompletePokemonRealm>()
    }
    
    func isFavorite(element: Pokemon) -> Bool {
        let results = returnFavorites().filter("id == \(element.id!)")
        return results.count > 0
    }
    
    func sortElementsById(_ list: [AnyObject]) -> [AnyObject] {
        let sortedElements = list.sorted {
            $0.id < $1.id
        }
        return sortedElements
    }
    
    func filterByName(searchQuery: String) {
        let filterArray = allSimplePokemonData!.filterByName(searchQuery)
    }
    
    func saveDataOnRealm() {
        let realm = try! Realm()
        try! realm.write {
            let dataRealm = DataRealm()
            dataRealm.savedData = "savedData"
            let allSimplePokemonData = List<SimplePokemonRealm>()
            for index in 0...(self.allSimplePokemonData!.count - 1) {
                let simpleDataPokemon = self.allSimplePokemonData![index]
                let realmPokemon = SimplePokemonRealm()
                realmPokemon.name = simpleDataPokemon.name.capitalizingFirstLetter()
                realmPokemon.url = simpleDataPokemon.url.capitalizingFirstLetter()
                allSimplePokemonData.append(realmPokemon)
            }
            dataRealm.allSimplePokemonData = allSimplePokemonData
            realm.add(dataRealm)
        }
    }
    
    func loadSimplePokemonList(onComplete: @escaping (Bool) -> Void) {
        let realm = try! Realm()
        let dataRealm = realm.objects(DataRealm.self)
        let emptyData = dataRealm.count == 0
        
        if(emptyData) {
            pokemonAPI.getAllPokemonSimpleData { (allSimplePokemonData, success) in
                self.allSimplePokemonData = allSimplePokemonData
                self.saveDataOnRealm()
            }
        }
        self.loadListWithCompleteData(onComplete: { (listWithCompleteData, success) in
            onComplete(success)
        })
    }
    func loadListWithCompleteData(onComplete: @escaping ([Pokemon]?, Bool) -> Void) {
        pokemonAPI.getListWithCompleteData { (listWithCompleteData, success) in
            if(listWithCompleteData != nil) {
                self.listWithCompleteData.append(contentsOf: listWithCompleteData!.sortElementsById())
                self.filterArray = self.listWithCompleteData
                self.tableView.reloadData()
                onComplete(listWithCompleteData, success)
            }
        }
    }
    
    func getTableCustomCell(tableView: UITableView, collectionView: UICollectionView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonTableViewCell") as! PokemonTableViewCell
        cell.setup(pokemon: filterArray[indexPath.row])
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
        
        return returnFavorites().count
    }
    
    func getCollectionCustomCell(tableView: UITableView, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectionViewCell", for: indexPath) as! FavoriteCollectionViewCell
        if(self.listWithCompleteData.count > 0) {
            let index = returnFavorites()[indexPath.row].id.value!
            cell.setup(pokemon: self.listWithCompleteData[index - 1])
        }
        cell.remove{ (pokemon) in
            self.removeFavorite(withId: pokemon.id!)
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
