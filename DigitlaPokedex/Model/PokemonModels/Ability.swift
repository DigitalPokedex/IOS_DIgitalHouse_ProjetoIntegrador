//
//  Ability.swift
//  DigitlaPokedex
//
//  Created by Jorge Carvalho on 10/01/21.
//

import Foundation

class Ability: NSObject, NSCoding{

    var name : String!
    var url : String!
    var ability : Ability!
    var isHidden : Bool!
    var slot : Int!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        name = dictionary["name"] as? String
        url = dictionary["url"] as? String
        if let abilityData = dictionary["ability"] as? [String:Any]{
            ability = Ability(fromDictionary: abilityData)
        }
        isHidden = dictionary["is_hidden"] as? Bool
        slot = dictionary["slot"] as? Int
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if name != nil{
            dictionary["name"] = name
        }
        if url != nil{
            dictionary["url"] = url
        }
        if ability != nil{
            dictionary["ability"] = ability.toDictionary()
        }
        if isHidden != nil{
            dictionary["is_hidden"] = isHidden
        }
        if slot != nil{
            dictionary["slot"] = slot
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         name = aDecoder.decodeObject(forKey: "name") as? String
         url = aDecoder.decodeObject(forKey: "url") as? String
         ability = aDecoder.decodeObject(forKey: "ability") as? Ability
         isHidden = aDecoder.decodeObject(forKey: "is_hidden") as? Bool
         slot = aDecoder.decodeObject(forKey: "slot") as? Int

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if url != nil{
            aCoder.encode(url, forKey: "url")
        }
        if ability != nil{
            aCoder.encode(ability, forKey: "ability")
        }
        if isHidden != nil{
            aCoder.encode(isHidden, forKey: "is_hidden")
        }
        if slot != nil{
            aCoder.encode(slot, forKey: "slot")
        }

    }

}
