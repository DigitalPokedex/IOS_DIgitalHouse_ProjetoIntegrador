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
    private var allSimplePokemonData = List<PokemonRealm>()
    private var filterArray = List<PokemonRealm>()
    
    func loadData() {
        let realm = try! Realm()
        let allSimplePokemonData = realm.objects(PokemonRealm.self)
        print(allSimplePokemonData.count)
        self.filterArray = self.allSimplePokemonData
        
    }
    
    func getNumberOfTableViewCells() -> Int {
        print(self.filterArray.count)
        
        return self.filterArray.count
    }
    
    func getTableCustomCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchScreenTableViewCell") as! SearchScreenTableViewCell
        cell.setup(pokemon: filterArray[indexPath.row])
        cell.add{ (pokemon) in
            tableView.reloadData()
            //self.favoritesList.append(pokemon.id)
            //self.favoritesList = self.sortNumbers(self.favoritesList)
        }
        return cell
    }
}
