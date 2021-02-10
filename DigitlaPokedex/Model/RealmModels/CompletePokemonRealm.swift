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
    var isDefault = RealmOptional<Bool>()
    var isFavorite = RealmOptional<Bool>()
    @objc dynamic var locationAreaEncounters: String? = nil
    var moves: [Form]? = []
    var order = RealmOptional<Int>()
    var species : Form? = nil
    @objc dynamic var sprites : String? = nil
    var stats: [Stat]? = []
    var types = List<TypeRealm>()
    var weight = RealmOptional<Int>()
    
    
    private static func convertToRealmType(_ types: [Type]) -> List<TypeRealm> {
        let convertedTypes = List<TypeRealm>()
        for index in 0...(types.count - 1) {
            let newType = TypeRealm()
            let newForm = FormRealm()
            newType.slot = RealmOptional(types[index].slot)
            newForm.name = types[index].type.name
            newForm.url = types[index].type.url
            newType.type = newForm
            
            convertedTypes.append(newType)
        }
        
        return convertedTypes
    }
    
    static func convertPokemonToRealm(original: Pokemon) -> CompletePokemonRealm {
        let converted = CompletePokemonRealm()
        
        converted.abilities = original.abilities
        converted.baseExperience = RealmOptional(original.baseExperience)
        converted.name = original.name
        converted.forms = original.forms
        converted.height = RealmOptional(original.height)
        converted.heldItems = original.heldItems
        converted.id = RealmOptional(original.id)
        converted.isDefault = RealmOptional(original.isDefault)
        converted.isFavorite = RealmOptional(original.isFavorite)
        converted.locationAreaEncounters = original.locationAreaEncounters
        converted.moves = original.moves
        converted.order = RealmOptional(original.order)
        converted.species = original.species
        converted.sprites = original.sprites.other.officialartwork.frontDefault!
        converted.stats = original.stats
        //print(original.types)
        
        converted.types = self.convertToRealmType(original.types)
        converted.weight = RealmOptional(original.weight)
        
        return converted
    }
    
    func getName() -> String {
        return "\(String(describing: name))".lowercased()
    }
}


