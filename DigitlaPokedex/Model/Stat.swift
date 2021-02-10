//
//  Stat.swift
//  DigitlaPokedex
//
//  Created by Jorge Carvalho on 10/01/21.
//

import Foundation

class Stat: NSObject, NSCoding{

    var baseStat : Int!
    var effort : Int!
    var stat : Form!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        baseStat = dictionary["base_stat"] as? Int
        effort = dictionary["effort"] as? Int
        if let statData = dictionary["stat"] as? [String:Any]{
            stat = Form(fromDictionary: statData)
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if baseStat != nil{
            dictionary["base_stat"] = baseStat
        }
        if effort != nil{
            dictionary["effort"] = effort
        }
        if stat != nil{
            dictionary["stat"] = stat.toDictionary()
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         baseStat = aDecoder.decodeObject(forKey: "base_stat") as? Int
         effort = aDecoder.decodeObject(forKey: "effort") as? Int
         stat = aDecoder.decodeObject(forKey: "stat") as? Form

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if baseStat != nil{
            aCoder.encode(baseStat, forKey: "base_stat")
        }
        if effort != nil{
            aCoder.encode(effort, forKey: "effort")
        }
        if stat != nil{
            aCoder.encode(stat, forKey: "stat")
        }

    }

}
