//
//  Pokemon.swift
//  DigitlaPokedex
//
//  Created by Jorge Carvalho on 10/01/21.
//

import Foundation


class Pokemon: NSObject, NSCoding{

    var abilities : [Ability]!
    var baseExperience : Int!
    var forms : [Form]!
    var height : Int!
    var heldItems : [AnyObject]!
    var id : Int!
    var isDefault : Bool!
    var isFavorite: Bool!
    var locationAreaEncounters : String!
    var moves : [Form]!
    var name : String!
    var order : Int!
    var species : Form!
    var sprites : Sprite!
    var stats : [Form]!
    var types : [Type]!
    var weight : Int!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        abilities = [Ability]()
        if let abilitiesArray = dictionary["abilities"] as? [[String:Any]]{
            for dic in abilitiesArray{
                let value = Ability(fromDictionary: dic)
                abilities.append(value)
            }
        }
        baseExperience = dictionary["base_experience"] as? Int
        forms = [Form]()
        if let formsArray = dictionary["forms"] as? [[String:Any]]{
            for dic in formsArray{
                let value = Form(fromDictionary: dic)
                forms.append(value)
            }
        }
        height = dictionary["height"] as? Int
        heldItems = dictionary["held_items"] as? [AnyObject]
        id = dictionary["id"] as? Int
        isDefault = dictionary["is_default"] as? Bool
        locationAreaEncounters = dictionary["location_area_encounters"] as? String
        moves = [Form]()
        if let movesArray = dictionary["moves"] as? [[String:Any]]{
            for dic in movesArray{
                let value = Form(fromDictionary: dic)
                moves.append(value)
            }
        }
        name = dictionary["name"] as? String
        order = dictionary["order"] as? Int
        if let speciesData = dictionary["species"] as? [String:Any]{
            species = Form(fromDictionary: speciesData)
        }
        if let spritesData = dictionary["sprites"] as? [String:Any]{
            sprites = Sprite(fromDictionary: spritesData)
        }
        stats = [Form]()
        if let statsArray = dictionary["stats"] as? [[String:Any]]{
            for dic in statsArray{
                let value = Form(fromDictionary: dic)
                stats.append(value)
            }
        }
        types = [Type]()
        if let typesArray = dictionary["types"] as? [[String:Any]]{
            for dic in typesArray{
                let value = Type(fromDictionary: dic)
                print(value)
                
                types.append(value)
            }
        }
        weight = dictionary["weight"] as? Int
    }

    func getName() -> String {
        return "\(String(describing: name))".lowercased()
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if abilities != nil{
            var dictionaryElements = [[String:Any]]()
            for abilitiesElement in abilities {
                dictionaryElements.append(abilitiesElement.toDictionary())
            }
            dictionary["abilities"] = dictionaryElements
        }
        if baseExperience != nil{
            dictionary["base_experience"] = baseExperience
        }
        if forms != nil{
            var dictionaryElements = [[String:Any]]()
            for formsElement in forms {
                dictionaryElements.append(formsElement.toDictionary())
            }
            dictionary["forms"] = dictionaryElements
        }
        if height != nil{
            dictionary["height"] = height
        }
        if heldItems != nil{
            dictionary["held_items"] = heldItems
        }
        if id != nil{
            dictionary["id"] = id
        }
        if isDefault != nil{
            dictionary["is_default"] = isDefault
        }
        if locationAreaEncounters != nil{
            dictionary["location_area_encounters"] = locationAreaEncounters
        }
        if moves != nil{
            var dictionaryElements = [[String:Any]]()
            for movesElement in moves {
                dictionaryElements.append(movesElement.toDictionary())
            }
            dictionary["moves"] = dictionaryElements
        }
        if name != nil{
            dictionary["name"] = name
        }
        if order != nil{
            dictionary["order"] = order
        }
        if species != nil{
            dictionary["species"] = species.toDictionary()
        }
        if sprites != nil{
            dictionary["sprites"] = sprites.toDictionary()
        }
        if stats != nil{
            var dictionaryElements = [[String:Any]]()
            for statsElement in stats {
                dictionaryElements.append(statsElement.toDictionary())
            }
            dictionary["stats"] = dictionaryElements
        }
        if types != nil{
            var dictionaryElements = [[String:Any]]()
            for typesElement in types {
                dictionaryElements.append(typesElement.toDictionary())
            }
            dictionary["types"] = dictionaryElements
        }
        if weight != nil{
            dictionary["weight"] = weight
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         abilities = aDecoder.decodeObject(forKey :"abilities") as? [Ability]
         baseExperience = aDecoder.decodeObject(forKey: "base_experience") as? Int
         forms = aDecoder.decodeObject(forKey :"forms") as? [Form]
         height = aDecoder.decodeObject(forKey: "height") as? Int
         heldItems = aDecoder.decodeObject(forKey: "held_items") as? [AnyObject]
         id = aDecoder.decodeObject(forKey: "id") as? Int
         isDefault = aDecoder.decodeObject(forKey: "is_default") as? Bool
         locationAreaEncounters = aDecoder.decodeObject(forKey: "location_area_encounters") as? String
         moves = aDecoder.decodeObject(forKey :"moves") as? [Form]
         name = aDecoder.decodeObject(forKey: "name") as? String
         order = aDecoder.decodeObject(forKey: "order") as? Int
         species = aDecoder.decodeObject(forKey: "species") as? Form
         sprites = aDecoder.decodeObject(forKey: "sprites") as? Sprite
         stats = aDecoder.decodeObject(forKey :"stats") as? [Form]
         types = aDecoder.decodeObject(forKey :"types") as? [Type]
         weight = aDecoder.decodeObject(forKey: "weight") as? Int

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if abilities != nil{
            aCoder.encode(abilities, forKey: "abilities")
        }
        if baseExperience != nil{
            aCoder.encode(baseExperience, forKey: "base_experience")
        }
        if forms != nil{
            aCoder.encode(forms, forKey: "forms")
        }
        if height != nil{
            aCoder.encode(height, forKey: "height")
        }
        if heldItems != nil{
            aCoder.encode(heldItems, forKey: "held_items")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if isDefault != nil{
            aCoder.encode(isDefault, forKey: "is_default")
        }
        if locationAreaEncounters != nil{
            aCoder.encode(locationAreaEncounters, forKey: "location_area_encounters")
        }
        if moves != nil{
            aCoder.encode(moves, forKey: "moves")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if order != nil{
            aCoder.encode(order, forKey: "order")
        }
        if species != nil{
            aCoder.encode(species, forKey: "species")
        }
        if sprites != nil{
            aCoder.encode(sprites, forKey: "sprites")
        }
        if stats != nil{
            aCoder.encode(stats, forKey: "stats")
        }
        if types != nil{
            aCoder.encode(types, forKey: "types")
        }
        if weight != nil{
            aCoder.encode(weight, forKey: "weight")
        }

    }

}
