//
//  VersionGroupDetail.swift
//  DigitlaPokedex
//
//  Created by Jorge Carvalho on 10/01/21.
//

import Foundation

class VersionGroupDetail: NSObject, NSCoding{

    var levelLearnedAt : Int!
    var moveLearnMethod : Form!
    var versionGroup : Form!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        levelLearnedAt = dictionary["level_learned_at"] as? Int
        if let moveLearnMethodData = dictionary["move_learn_method"] as? [String:Any]{
            moveLearnMethod = Form(fromDictionary: moveLearnMethodData)
        }
        if let versionGroupData = dictionary["version_group"] as? [String:Any]{
            versionGroup = Form(fromDictionary: versionGroupData)
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if levelLearnedAt != nil{
            dictionary["level_learned_at"] = levelLearnedAt
        }
        if moveLearnMethod != nil{
            dictionary["move_learn_method"] = moveLearnMethod.toDictionary()
        }
        if versionGroup != nil{
            dictionary["version_group"] = versionGroup.toDictionary()
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         levelLearnedAt = aDecoder.decodeObject(forKey: "level_learned_at") as? Int
         moveLearnMethod = aDecoder.decodeObject(forKey: "move_learn_method") as? Form
         versionGroup = aDecoder.decodeObject(forKey: "version_group") as? Form

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if levelLearnedAt != nil{
            aCoder.encode(levelLearnedAt, forKey: "level_learned_at")
        }
        if moveLearnMethod != nil{
            aCoder.encode(moveLearnMethod, forKey: "move_learn_method")
        }
        if versionGroup != nil{
            aCoder.encode(versionGroup, forKey: "version_group")
        }

    }

}
