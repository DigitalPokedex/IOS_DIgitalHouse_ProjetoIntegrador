//
//  InitialFavoritesRegistrationViewModel.swift
//  DigitlaPokedex
//
//  Created by Jorge Carvalho on 05/01/21.
//

import Foundation
import UIKit

class InitialFavoritesRegistrationViewModel {
    private var navigationController: UINavigationController!
    var pokemonAPI = PokemonAPI()
    var pokemonNumber = 1
    var allSimplePokemonData: [PokemonSimpleData]?
    var listWithCompleteData = [Pokemon]()
    
    func sortElementsById(_ list: [Pokemon]) -> [Pokemon] {
        let sortedElements = list.sorted {
            $0.id < $1.id
        }
        return sortedElements
    }
    
    func loadSimplePokemonList(onComplete: @escaping (Bool) -> Void) {
        pokemonAPI.getAllPokemonSimpleData { (allSimplePokemonData, success) in
            self.allSimplePokemonData = allSimplePokemonData
            self.loadListWithCompleteData(onComplete: { (listWithCompleteData, success) in
            })
            onComplete(success)
        }
    }
    func loadListWithCompleteData(onComplete: @escaping ([Pokemon]?, Bool) -> Void) {
        pokemonAPI.getListWithCompleteData { (listWithCompleteData, success) in
            if(listWithCompleteData != nil) {
                self.listWithCompleteData.append(contentsOf: self.sortElementsById(listWithCompleteData!))
                onComplete(listWithCompleteData, success)
            }
        }
    }
    
    func setupNavigationController(navigationController: UINavigationController!) {
        self.navigationController = navigationController
    }
    
    func toPreviousScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    func saveFavorites() {
        let tabbar = TabBarController.shared
        navigationController?.pushViewController(tabbar, animated: true)
    }
}
