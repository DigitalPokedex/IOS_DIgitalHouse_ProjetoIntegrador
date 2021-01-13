//
//  OfficialArtwork.swift
//  DigitlaPokedex
//
//  Created by Jorge Carvalho on 10/01/21.
//

import Foundation


class OfficialArtwork : NSObject, NSCoding{

    var frontDefault : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        frontDefault = dictionary["front_default"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if frontDefault != nil{
            dictionary["front_default"] = frontDefault
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         frontDefault = aDecoder.decodeObject(forKey: "front_default") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if frontDefault != nil{
            aCoder.encode(frontDefault, forKey: "front_default")
        }

    }

}
