//
//  SearchBarViewModel.swift
//  DigitlaPokedex
//
//  Created by Jorge Carvalho on 20/01/21.
//

import Foundation
import UIKit
import Realm
import RealmSwift

class SearchScreenViewModel {
    private var allSimplePokemonData = [SimplePokemonRealm]()
    private var filterArray = [SimplePokemonRealm]()
    
    var initialModalCenter: CGFloat!
    var finalModalCenter: CGFloat!
    var mainView: SearchScreen!
    var containerView: UIView!
    
    var isInitialFavorites = false

    func filterByName(searchQuery: String) {
        filterArray = allSimplePokemonData.filterByName(searchQuery)
    }
    
    func loadData() {
        let realm = try! Realm()
        let dataRealm = realm.objects(DataRealm.self)
        let savedData = dataRealm[0].allSimplePokemonData
        
        for index in 0...(savedData.count - 1) {
            let pokemon = SimplePokemonRealm()
            pokemon.name = savedData[index].name
            pokemon.url = savedData[index].url
            self.allSimplePokemonData.append(pokemon)
        }
        self.filterArray = self.allSimplePokemonData
        
    }
    
    
    private func closeScreen() {
        self.mainView.isHidden = true
    }
    
    func animateContainer(isInitial: Bool) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
                        self.containerView.center.y = isInitial ? CGFloat(0.0) : self.finalModalCenter
                       },
                       completion: {_ in
                        !isInitial ? self.closeScreen() : nil
                       })
    }
    
    func returnFavorites() -> List<CompletePokemonRealm> {
        let realm = try! Realm()
        let dataRealm = realm.objects(DataRealm.self)
        return dataRealm.count > 0 ? dataRealm[0].favorites : List<CompletePokemonRealm>()
    }
    
    func isFavorite(element: SimplePokemonRealm) -> Bool {
        let results = returnFavorites().filter{ arrayElement in arrayElement.getName() == element.getName() }
        return results.count > 0
    }
    
    func getCellHeight(tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        if(isFavorite(element: self.filterArray[indexPath.row]) && isInitialFavorites) {
            return 0
        }
        
        return tableView.rowHeight
    }
    
    func getFilteredArray() -> [SimplePokemonRealm] {
        return filterArray
    }
    
    func getNumberOfTableViewCells() -> Int {
        return self.filterArray.count
    }
    
    func getTableCustomCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchScreenTableViewCell", for: indexPath) as! SearchScreenTableViewCell
        
        cell.setup(pokemon: filterArray[indexPath.row])
        cell.add{ (pokemon) in
            tableView.reloadData()
            //self.favoritesList.append(pokemon)
            //self.favoritesList = self.sortNumbers(self.favoritesList)
        }
        return cell
    }
}
