//
//  Type.swift
//  DigitlaPokedex
//
//  Created by Jorge Carvalho on 10/01/21.
//

import Foundation


class Type: NSObject, NSCoding{

    var slot : Int!
    var type : Form!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        slot = dictionary["slot"] as? Int
        if let typeData = dictionary["type"] as? [String:Any]{
            type = Form(fromDictionary: typeData)
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if slot != nil{
            dictionary["slot"] = slot
        }
        if type != nil{
            dictionary["type"] = type.toDictionary()
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         slot = aDecoder.decodeObject(forKey: "slot") as? Int
         type = aDecoder.decodeObject(forKey: "type") as? Form

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if slot != nil{
            aCoder.encode(slot, forKey: "slot")
        }
        if type != nil{
            aCoder.encode(type, forKey: "type")
        }

    }

}
