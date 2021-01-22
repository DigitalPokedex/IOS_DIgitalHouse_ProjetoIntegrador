//
//  CompletePokemonRealm.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 21/01/21.
//

import Foundation
import RealmSwift
import Realm

class CompletePokemonRealm: Object {
    var abilities: [Ability]? = []
    var baseExperience = RealmOptional<Int>()
    @objc dynamic var name: String? = nil
    var forms: [Form]? = []
    var height = RealmOptional<Int>()
    var heldItems: [AnyObject]? = []
    var id = RealmOptional<Int>()
    var isDefault : Bool!
    var isFavorite: Bool!
    @objc dynamic var locationAreaEncounters : String!
    var moves: [Form]? = []
    var order = RealmOptional<Int>()
    var species : Form? = nil
    var sprites : Sprite? = nil
    var stats: [Form]? = []
    var types: [Form]? = []
    var weight = RealmOptional<Int>()
    
    static func convertPokemonToRealm(original: Pokemon) -> CompletePokemonRealm {
        var converted = CompletePokemonRealm()
        
        converted.abilities = original.abilities
        converted.baseExperience = RealmOptional(original.baseExperience)
        converted.name = original.name
        converted.forms = original.forms
        converted.height = RealmOptional(original.height)
        converted.heldItems = original.heldItems
        converted.id = RealmOptional(original.id)
        converted.isDefault = original.isDefault
        converted.isFavorite = original.isFavorite
        converted.locationAreaEncounters = original.locationAreaEncounters
        converted.moves = original.moves
        converted.order = RealmOptional(original.order)
        converted.species = original.species
        converted.sprites = original.sprites
        converted.stats = original.stats
        converted.types = original.types
        converted.weight = RealmOptional(original.weight)
        
        return converted
    }
    
    func getName() -> String {
        return "\(String(describing: name))".lowercased()
    }
}


