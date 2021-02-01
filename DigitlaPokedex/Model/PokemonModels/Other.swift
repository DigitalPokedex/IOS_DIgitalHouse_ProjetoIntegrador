//
//  Other.swift
//  DigitlaPokedex
//
//  Created by Jorge Carvalho on 10/01/21.
//

import Foundation

class Other: NSObject, NSCoding{

    var dreamWorld : DreamWorld!
    var officialartwork : OfficialArtwork!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        if let dreamWorldData = dictionary["dream_world"] as? [String:Any]{
            dreamWorld = DreamWorld(fromDictionary: dreamWorldData)
        }
        if let officialartworkData = dictionary["official-artwork"] as? [String:Any]{
            officialartwork = OfficialArtwork(fromDictionary: officialartworkData)
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if dreamWorld != nil{
            dictionary["dream_world"] = dreamWorld.toDictionary()
        }
        if officialartwork != nil{
            dictionary["official-artwork"] = officialartwork.toDictionary()
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         dreamWorld = aDecoder.decodeObject(forKey: "dream_world") as? DreamWorld
         officialartwork = aDecoder.decodeObject(forKey: "official-artwork") as? OfficialArtwork

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if dreamWorld != nil{
            aCoder.encode(dreamWorld, forKey: "dream_world")
        }
        if officialartwork != nil{
            aCoder.encode(officialartwork, forKey: "official-artwork")
        }

    }

}
