//
//  TableViewDelegateDataSOurce.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 11/01/21.
//
import Foundation
import UIKit
import Realm
import RealmSwift

class InitialFavoritesTableViewDelegateDataSource: NSObject, UITableViewDelegate, UITableViewDataSource  {
    let viewModel: InitialFavoritesRegistrationViewModel!
    let collectionView: UICollectionView!
    
    init(viewModel: InitialFavoritesRegistrationViewModel, collectionView: UICollectionView) {
        self.viewModel = viewModel
        self.collectionView = collectionView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let realm = try! Realm()
        try! realm.write {
            let dataRealm = realm.objects(DataRealm.self)
            let convertedPokemon = CompletePokemonRealm.convertPokemonToRealm(original: self.viewModel.filterArray[indexPath.row])
            dataRealm[0].favorites.append(convertedPokemon)
        }
        collectionView.reloadData()
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfTableViewCells(tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = viewModel.getCellHeight(tableView: tableView, indexPath: indexPath)
        
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = viewModel.getTableCustomCell(tableView: tableView, collectionView: self.collectionView, indexPath: indexPath)
        
        return cell
    }
}
