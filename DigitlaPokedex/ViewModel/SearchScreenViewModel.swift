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
    private var allSimplePokemonData = [PokemonRealm]()
    private var filterArray = [PokemonRealm]()
    
    //var allSimplePokemonData = BindableResults(results: try! Realm().objects(PokemonRealm.self))
    //var filterArray = BindableResults(results: try! Realm().objects(PokemonRealm.self))

    func filterByName(searchQuery: String) {
        filterArray = allSimplePokemonData.filterByName(searchQuery)
    }
    
    func loadData() {
        let realm = try! Realm()
        let allSimplePokemonData = realm.objects(PokemonRealm.self)
        for index in 0...(allSimplePokemonData.count - 1) {
            let pokemon = PokemonRealm()
            pokemon.name = allSimplePokemonData[index].name
            pokemon.url = allSimplePokemonData[index].url
            self.allSimplePokemonData.append(pokemon)
        }
        //self.allSimplePokemonData = allSimplePokemonData
        self.filterArray = self.allSimplePokemonData
        
    }
    
    func getNumberOfTableViewCells() -> Int {
        return self.filterArray.count
    }
    
    func getTableCustomCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchScreenTableViewCell", for: indexPath) as! SearchScreenTableViewCell
        
        cell.setup(pokemon: filterArray[indexPath.row])
        cell.add{ (pokemon) in
            tableView.reloadData()
            //self.favoritesList.append(pokemon.id)
            //self.favoritesList = self.sortNumbers(self.favoritesList)
        }
        return cell
    }
}
