//
//  SearchScreenTableViewDelegateDataSource.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 21/01/21.
//

import Foundation
import UIKit
import Realm
import RealmSwift

class SearchScreenTableViewDelegateDataSource: NSObject, UITableViewDelegate, UITableViewDataSource  {
    let viewModel: SearchScreenViewModel!
    let parentViewModel: DefaultViewModelProtocol!
    
    init(viewModel: SearchScreenViewModel, parentViewModel: DefaultViewModelProtocol) {
        self.viewModel = viewModel
        self.parentViewModel = parentViewModel
    }
    
    func indexOnCompleteList(indexPath: IndexPath) -> Int? {
        let completeList = self.parentViewModel.returnListWithCompleteData()
        let element = self.viewModel.getFilteredArray()[indexPath.row].getName()
        let index = completeList.firstIndex { $0.getName() == element }
        
        return index
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let realm = try! Realm()
        try! realm.write {
            if let index = indexOnCompleteList(indexPath: indexPath) {
                let completeList = self.parentViewModel.returnListWithCompleteData()
                let convertedPokemon = CompletePokemonRealm.convertPokemonToRealm(original: completeList[index])
                let dataRealm = realm.objects(DataRealm.self)
                dataRealm[0].favorites.append(convertedPokemon)
                
                self.parentViewModel.reloadData()
            }
            
            self.viewModel.animateContainer(isInitial: false)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let info = viewModel.getNumberOfTableViewCells()
        return info
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = viewModel.getCellHeight(tableView: tableView, indexPath: indexPath)
        
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = viewModel.getTableCustomCell(tableView: tableView, indexPath: indexPath)
        
        return cell
    }
}
