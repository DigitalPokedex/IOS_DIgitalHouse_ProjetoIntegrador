//
//  TableViewDelegateDataSOurce.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 11/01/21.
//
import Foundation
import UIKit

class InitialFavoritesTableViewDelegateDataSource: NSObject, UITableViewDelegate, UITableViewDataSource  {
    let viewModel: InitialFavoritesRegistrationViewModel!
    let collectionView: UICollectionView!
    
    init(viewModel: InitialFavoritesRegistrationViewModel, collectionView: UICollectionView) {
        self.viewModel = viewModel
        self.collectionView = collectionView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
