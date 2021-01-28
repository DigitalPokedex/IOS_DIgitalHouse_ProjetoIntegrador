//
//  HomeScreenViewModel.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 22/01/21.
//

import Foundation
import UIKit
import UIScrollView_InfiniteScroll
import Realm
import RealmSwift

class HomeScreenViewModel: DefaultViewModelProtocol {
    private var collectionView: UICollectionView!
    private var navigationController: UINavigationController!
    var allSimplePokemonData: [PokemonSimpleData]?
    var pokemonAPI = PokemonAPI()
    var listWithCompleteData = [Pokemon]()
    var filterArray = [Pokemon]()
    
    func reloadData() {
        self.collectionView.reloadData()
    }
    
    func configureViewModel(navigationController: UINavigationController!, collectionView: UICollectionView!) {
        self.navigationController = navigationController
        
        self.collectionView = collectionView
        collectionView.addInfiniteScroll { (collectionView) -> Void in
            self.loadListWithCompleteData(onComplete: { (listWithCompleteData, success) in
                collectionView.finishInfiniteScroll()
                self.reloadData()
            })
        }
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
                onComplete(listWithCompleteData, success)
            }
        }
    }
    
    func returnListWithCompleteData() -> [Pokemon] {
        return listWithCompleteData
    }
    
    func getNumberOfCells(collectionView: UICollectionView) -> Int {
        return filterArray.count
    }
    
    func getCustomCollectionCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeAndFavoriteCollectionViewCell", for: indexPath) as! HomeAndFavoriteCollectionViewCell
        cell.setupFromWeb(pokemon: filterArray[indexPath.row])
        return cell
    }

}
