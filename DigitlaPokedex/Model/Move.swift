//
//  Move.swift
//  DigitlaPokedex
//
//  Created by Jorge Carvalho on 10/01/21.
//

import Foundation

class Move: NSObject, NSCoding{

    var move : Form!
    var versionGroupDetails : [VersionGroupDetail]!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        if let moveData = dictionary["move"] as? [String:Any]{
            move = Form(fromDictionary: moveData)
        }
        versionGroupDetails = [VersionGroupDetail]()
        if let versionGroupDetailsArray = dictionary["version_group_details"] as? [[String:Any]]{
            for dic in versionGroupDetailsArray{
                let value = VersionGroupDetail(fromDictionary: dic)
                versionGroupDetails.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if move != nil{
            dictionary["move"] = move.toDictionary()
        }
        if versionGroupDetails != nil{
            var dictionaryElements = [[String:Any]]()
            for versionGroupDetailsElement in versionGroupDetails {
                dictionaryElements.append(versionGroupDetailsElement.toDictionary())
            }
            dictionary["version_group_details"] = dictionaryElements
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         move = aDecoder.decodeObject(forKey: "move") as? Form
         versionGroupDetails = aDecoder.decodeObject(forKey :"version_group_details") as? [VersionGroupDetail]

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if move != nil{
            aCoder.encode(move, forKey: "move")
        }
        if versionGroupDetails != nil{
            aCoder.encode(versionGroupDetails, forKey: "version_group_details")
        }

    }

}
