//
//  TypeRealm.swift
//  DigitlaPokedex
//
//  Created by Jorge Carvalho on 31/01/21.
//

import Foundation
import RealmSwift
import Realm

class TypeRealm: Object {
    // Optional string property, defaulting to nil
    var slot = RealmOptional<Int>()
    @objc dynamic var type: FormRealm!
}
