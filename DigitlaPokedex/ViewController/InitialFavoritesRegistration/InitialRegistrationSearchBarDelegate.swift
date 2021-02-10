//
//  InitialRgistrationSearchBarDelegate.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 11/01/21.
//

import Foundation
import UIKit

class SearchBarDelegate: NSObject, UISearchBarDelegate {
    let viewModel: SearchScreenViewModel!
    let tableView: UITableView?
    
    init(viewModel: SearchScreenViewModel, tableView: UITableView) {
        self.viewModel = viewModel
        self.tableView = tableView
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterByName(searchQuery: searchText)
        tableView?.reloadData()
    }
    
    
}

