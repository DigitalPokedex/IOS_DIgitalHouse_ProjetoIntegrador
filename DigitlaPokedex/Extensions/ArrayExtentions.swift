//
//  SearchExtentions.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 13/01/21.
//

import Foundation
extension Array where Element == Pokemon {
    func sortElementsById() -> [Pokemon] {
        let sortedElements = self.sorted {
            $0.id < $1.id
        }
        return sortedElements
    }
    func filterByName(_ searchQuery: String) -> [Pokemon] {
        var filterArray = [Pokemon]()
        if !searchQuery.isEmpty {
            filterArray = self.filter { (element) -> Bool in
                element.getName().contains(searchQuery.lowercased())
            }
        } else {
            filterArray.append(contentsOf: self)
        }
        return filterArray
    }
}

extension Array where Element == PokemonSimpleData {
    func filterByName(_ searchQuery: String) -> [PokemonSimpleData] {
        var filterArray = [PokemonSimpleData]()
        if !searchQuery.isEmpty {
            filterArray = self.filter { (element) -> Bool in
                element.getName().contains(searchQuery.lowercased())
            }
        } else {
            filterArray.append(contentsOf: self)
        }
        return filterArray
    }
}

extension Array where Element == SimplePokemonRealm {
    func filterByName(_ searchQuery: String) -> [SimplePokemonRealm] {
        var filterArray = [SimplePokemonRealm]()
        if !searchQuery.isEmpty {
            filterArray = self.filter { (element) -> Bool in
                element.getName().contains(searchQuery.lowercased())
            }
        } else {
            filterArray.append(contentsOf: self)
        }
        return filterArray
    }
}
