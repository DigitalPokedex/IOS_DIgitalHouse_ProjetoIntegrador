//
//  SearchScreenTableViewDelegateDataSource.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 21/01/21.
//

import Foundation
import UIKit

class SearchScreenTableViewDelegateDataSource: NSObject, UITableViewDelegate, UITableViewDataSource  {
    let viewModel: SearchScreenViewModel!
    
    init(viewModel: SearchScreenViewModel) {
        self.viewModel = viewModel
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let info = viewModel.getNumberOfTableViewCells()
        return info
    }
    
    /*func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = viewModel.getCellHeight(tableView: tableView, indexPath: indexPath)
        
        return cellHeight
    }*/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = viewModel.getTableCustomCell(tableView: tableView, indexPath: indexPath)
        
        return cell
    }
}
