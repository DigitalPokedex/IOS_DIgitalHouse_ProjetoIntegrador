//
//  FormReal.swift
//  DigitlaPokedex
//
//  Created by Jorge Carvalho on 31/01/21.
//

import Foundation
import RealmSwift
import Realm


class FormRealm: Object {
    // Optional string property, defaulting to nil
    @objc dynamic var name: String? = nil
    @objc dynamic var url : String? = nil
}
