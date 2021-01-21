//
//  PokemonReal.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 21/01/21.
//

import Foundation
import Realm
import RealmSwift

class PokemonRealm: Object {
    @objc dynamic var name: String!
    @objc dynamic var url: String!
}
