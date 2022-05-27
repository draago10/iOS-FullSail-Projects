//
//  Character.swift
//  WendelDaniel_CE01
//
//  Created by Daniel Wendel on 5/3/21.
//

import UIKit

class Character {
    //Stored Properties
    var firstName : String
    var lastName : String
    var age : Int
    var weapons : [String]
    var characterImage : UIImage
    var mainCharacter : Bool
    var characterDesription : String
    
    
    //Computed Properties
    var fullName : String {
        get {
            return "\(firstName) \(lastName)"
        }
    }
    
    //Method(s)
    
    func getFullDescription() -> String{
        var fullDescription = ""
        
        fullDescription += "Character name: \(fullName)\n\nAge: \(age)\n\nMain Character: \(mainCharacter)\n\nWeapons: "
        
        for weapon in weapons{
            fullDescription += "\n\(weapon)"
        }
        
        fullDescription += "\n\nDescription:\n\(characterDesription)"
        
        return fullDescription
    }
    
    init(firstName: String, lastName: String, age: Int, weapons: [String], mainCharacter: Bool, image: UIImage, description: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.weapons = weapons
        self.characterImage = image
        self.mainCharacter = mainCharacter
        self.characterDesription = description
    }
}





