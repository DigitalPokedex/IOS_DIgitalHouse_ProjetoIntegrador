//
//  PokemonAPI.swift
//  DigitlaPokedex
//
//  Created by Jorge Carvalho on 05/01/21.
//

import Foundation

class PokemonAPI: NSObject {
    var apiManager = APIManager()
    private var pokemonIndex = 0
    private var indexLimit = 0
    private var maxIndex = 1118
    private var numberOfTasks = 0
    let dispatchQueue = DispatchQueue(label: "any-label-name")
    let dispatchGroup = DispatchGroup()
    let dispatchSemaphore = DispatchSemaphore(value: 0)
    let baseUrl = "https://pokeapi.co/api/v2"
    
    private func parseSimplePokemonData(rootData: Any?) -> [PokemonSimpleData]? {
        if let arrayDictionary = rootData as? [[String: Any]] {
            var array = [PokemonSimpleData]()
            
            for dictionary in arrayDictionary {
                let loadedData = PokemonSimpleData(fromDictionary: dictionary)
                array.append(loadedData)
            }
            return array
        }
        return nil
    }
    
    func getAllPokemonSimpleData(completion: @escaping ([PokemonSimpleData]?, Bool) -> Void) {
        apiManager.request(url: "\(baseUrl)/pokemon?offset=0&limit=\(maxIndex)") { (response) in
            
            if let dictionary = response as? [String: Any], let rootData = dictionary["results"] as? [[String: Any]] {
                if let allPokemonSimpleData = self.parseSimplePokemonData(rootData: rootData) {
                    completion(allPokemonSimpleData, true)
                    return
                }
                completion(nil, false)
                
            }
            completion(nil, false)
        }
    }
    
    private func shouldLoadMore() -> Bool {
        if(pokemonIndex < indexLimit && pokemonIndex < maxIndex) { return true }
        else { return false }
    }
    
    private func updateIndexes() {
        pokemonIndex = pokemonIndex + 1
        indexLimit = indexLimit + 20
    }
    
    private func getPokemon(completion: @escaping (Pokemon?, Bool) -> Void) {
        apiManager.request(url: "\(baseUrl)/pokemon/\(pokemonIndex)") { (response) in
            if let dictionary = response as? [String: Any] {
                let loadedData = Pokemon(fromDictionary: dictionary)
                
                //array.append(loadedData)
                completion(loadedData, true)
                
                return
            }
            completion(nil, false)
        }
        completion(nil, false)
    }
    
    func addTask() {
        numberOfTasks = numberOfTasks + 1
    }
    func removeTask() {
        if(numberOfTasks > 0) {
            numberOfTasks = numberOfTasks - 1
        }
        else {
            numberOfTasks = 0
        }
    }
    
    func getListWithCompleteData(completion: @escaping ([Pokemon]?, Bool) -> Void) {
        var array = [Pokemon]()
        updateIndexes()
        for index in pokemonIndex...self.indexLimit {
            if(self.shouldLoadMore()) {
                addTask()
                self.pokemonIndex = index
                self.getPokemon{(pokemon, success)  in
                    if let value = pokemon {
                        array.append(value)
                        self.removeTask()
                    }
                    
                    if(self.numberOfTasks == 0) {
                        completion(array, true)
                    }
                }
            }
        }
    }
}
