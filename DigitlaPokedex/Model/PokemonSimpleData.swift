//
//  PokemonSimpleData.swift
//  DigitlaPokedex
//
//  Created by Jorge Carvalho on 05/01/21.
//

import Foundation

class PokemonSimpleData : NSObject, NSCoding{

    var name : String!
    var url : String!

    init(fromDictionary dictionary: [String:Any]){
        name = dictionary["name"] as? String
        url = dictionary["url"] as? String
    }
    
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if name != nil{
            dictionary["name"] = name
        }
        if url != nil{
            dictionary["url"] = url
        }
        return dictionary
    }

    @objc required init(coder aDecoder: NSCoder)
    {
         name = aDecoder.decodeObject(forKey: "name") as? String
         url = aDecoder.decodeObject(forKey: "url") as? String

    }

    @objc func encode(with aCoder: NSCoder)
    {
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if url != nil{
            aCoder.encode(url, forKey: "url")
        }

    }

}
