//
//  Pokemon.swift
//  DigitlaPokedex
//
//  Created by Jorge Roberto on 23/11/20.
//

import Foundation

class Pokemon {
    let image: String
    let name: String
    let id: Int
    let types: [String]
    
    init(image: String, name: String, id: Int, types: [String]) {
        self.image = image
        self.name = name
        self.id = id
        self.types = types
    }
}
