//
//  InitialFavoritesCollectionViewDelegateDataSource.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 11/01/21.
//

import Foundation
import UIKit

class InitialFavoritesCollectionViewDelegateDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource  {
    let viewModel: InitialFavoritesRegistrationViewModel!
    let tableView: UITableView!
    
    init(viewModel: InitialFavoritesRegistrationViewModel, tableView: UITableView) {
        self.viewModel = viewModel
        self.tableView = tableView
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //print(viewModel.favoritesList[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberOfCollectionViewCells(collectionView: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = viewModel.getCollectionCustomCell(tableView: self.tableView, collectionView: collectionView, indexPath: indexPath)
        return cell
    }
}
