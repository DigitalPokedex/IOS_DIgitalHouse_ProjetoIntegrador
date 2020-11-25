//
//  Pokemon.swift
//  DigitlaPokedex
//
//  Created by Cesar A. Tavares on 21/11/20.
//

import Foundation

class PokemonTemp {
    
    var name: String
    var id: Int
    var type: String
    var description: String
    var image: String
    var hp: Double
    var atk: Double
    var def: Double
    var stak: Double
    var sdef: Double
    var spd: Double
    var favorite: Bool
    
    init(name: String, id: Int, type: String, description: String, image: String, hp: Double, atk: Double, def: Double, stak: Double, sdef: Double, spd: Double, favorite: Bool) {
        self.name = name
        self.id = id
        self.type = type
        self.description = description
        self.image = image
        self.hp = hp
        self.atk = atk
        self.def = def
        self.stak = stak
        self.sdef = sdef
        self.spd = spd
        self.favorite = favorite
    }
    
}
