//
//  Sprite.swift
//  DigitlaPokedex
//
//  Created by Jorge Carvalho on 10/01/21.
//

import Foundation

class Sprite: NSObject, NSCoding{

    var backDefault : String!
    var backFemale : AnyObject!
    var backShiny : String!
    var backShinyFemale : AnyObject!
    var frontDefault : String!
    var frontFemale : AnyObject!
    var frontShiny : String!
    var frontShinyFemale : AnyObject!
    var other : Other!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        backDefault = dictionary["back_default"] as? String
        backFemale = dictionary["back_female"] as? AnyObject
        backShiny = dictionary["back_shiny"] as? String
        backShinyFemale = dictionary["back_shiny_female"] as? AnyObject
        frontDefault = dictionary["front_default"] as? String
        frontFemale = dictionary["front_female"] as? AnyObject
        frontShiny = dictionary["front_shiny"] as? String
        frontShinyFemale = dictionary["front_shiny_female"] as? AnyObject
        if let otherData = dictionary["other"] as? [String:Any]{
            other = Other(fromDictionary: otherData)
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if backDefault != nil{
            dictionary["back_default"] = backDefault
        }
        if backFemale != nil{
            dictionary["back_female"] = backFemale
        }
        if backShiny != nil{
            dictionary["back_shiny"] = backShiny
        }
        if backShinyFemale != nil{
            dictionary["back_shiny_female"] = backShinyFemale
        }
        if frontDefault != nil{
            dictionary["front_default"] = frontDefault
        }
        if frontFemale != nil{
            dictionary["front_female"] = frontFemale
        }
        if frontShiny != nil{
            dictionary["front_shiny"] = frontShiny
        }
        if frontShinyFemale != nil{
            dictionary["front_shiny_female"] = frontShinyFemale
        }
        if other != nil{
            dictionary["other"] = other.toDictionary()
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         backDefault = aDecoder.decodeObject(forKey: "back_default") as? String
         backFemale = aDecoder.decodeObject(forKey: "back_female") as? AnyObject
         backShiny = aDecoder.decodeObject(forKey: "back_shiny") as? String
         backShinyFemale = aDecoder.decodeObject(forKey: "back_shiny_female") as? AnyObject
         frontDefault = aDecoder.decodeObject(forKey: "front_default") as? String
         frontFemale = aDecoder.decodeObject(forKey: "front_female") as? AnyObject
         frontShiny = aDecoder.decodeObject(forKey: "front_shiny") as? String
         frontShinyFemale = aDecoder.decodeObject(forKey: "front_shiny_female") as? AnyObject
         other = aDecoder.decodeObject(forKey: "other") as? Other

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if backDefault != nil{
            aCoder.encode(backDefault, forKey: "back_default")
        }
        if backFemale != nil{
            aCoder.encode(backFemale, forKey: "back_female")
        }
        if backShiny != nil{
            aCoder.encode(backShiny, forKey: "back_shiny")
        }
        if backShinyFemale != nil{
            aCoder.encode(backShinyFemale, forKey: "back_shiny_female")
        }
        if frontDefault != nil{
            aCoder.encode(frontDefault, forKey: "front_default")
        }
        if frontFemale != nil{
            aCoder.encode(frontFemale, forKey: "front_female")
        }
        if frontShiny != nil{
            aCoder.encode(frontShiny, forKey: "front_shiny")
        }
        if frontShinyFemale != nil{
            aCoder.encode(frontShinyFemale, forKey: "front_shiny_female")
        }
        if other != nil{
            aCoder.encode(other, forKey: "other")
        }

    }

}
