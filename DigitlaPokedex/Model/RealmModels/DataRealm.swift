//
//  DataRealm.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 21/01/21.
//

import Foundation
import RealmSwift
import Realm

class DataRealm: Object {
    // Optional string property, defaulting to nil
    @objc dynamic var savedData: String? = nil
    
    var allSimplePokemonData = List<SimplePokemonRealm>()
    var favorites = List<CompletePokemonRealm>()
}
