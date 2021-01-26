//
//  PokemonReal.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 21/01/21.
//

import Foundation
import Realm
import RealmSwift

class SimplePokemonRealm: Object {
    @objc dynamic var name: String!
    @objc dynamic var url: String!
    
    
    func getName() -> String {
        return "\(String(describing: name))".lowercased()
    }
}
