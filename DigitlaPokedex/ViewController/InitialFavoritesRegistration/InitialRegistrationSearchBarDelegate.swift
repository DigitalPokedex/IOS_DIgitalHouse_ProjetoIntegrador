//
//  InitialRgistrationSearchBarDelegate.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 11/01/21.
//

import Foundation
import UIKit

class InitialRegistrationSearchBarDelegate: NSObject, UISearchBarDelegate {
    let viewModel: InitialFavoritesRegistrationViewModel!
    let tableView: UITableView?
    let collectionView: UICollectionView?
    
    init(viewModel: InitialFavoritesRegistrationViewModel, tableView: UITableView, collectionView: UICollectionView) {
        self.viewModel = viewModel
        self.tableView = tableView
        self.collectionView = collectionView
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterArray(searchQuery: searchText)
        tableView?.reloadData()
        collectionView?.reloadData()
    }
    
    
}

