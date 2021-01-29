//
//  PokemonFavoritesViewModel.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 22/01/21.
//
//
//  InitialFavoritesRegistrationViewModel.swift
//  DigitlaPokedex
//
//  Created by Jorge Carvalho on 05/01/21.
//

import Foundation
import UIKit
import UIScrollView_InfiniteScroll
import Realm
import RealmSwift


class PokemonFavoritesViewModel {
    private var navigationController: UINavigationController!
    private var collectionView: UICollectionView!
    
    func reloadData() {
        self.collectionView.reloadData()
    }
    
    func configureViewModel(navigationController: UINavigationController!, collectionView: UICollectionView!) {
        self.navigationController = navigationController
        self.collectionView = collectionView
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
    
    
    func getNumberOfCells(collectionView: UICollectionView) -> Int {
        
        return returnFavorites().count
    }
    
    
    func getCustomCollectionCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeAndFavoriteCollectionViewCell", for: indexPath) as! HomeAndFavoriteCollectionViewCell
        cell.setup(pokemon: returnFavorites()[indexPath.row])
        return cell
    }
    
}
