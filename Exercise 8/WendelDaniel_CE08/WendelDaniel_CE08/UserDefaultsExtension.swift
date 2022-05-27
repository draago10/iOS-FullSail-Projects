//
//  UserDefaultsExtension.swift
//  WendelDaniel_CE08
//
//  Created by Daniel Wendel on 5/18/21.
//

import UIKit

extension UserDefaults{
    func set(color: UIColor, forKey key: String){
        let binaryData = try? NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true)
        
        self.set(binaryData, forKey: key)
        
    }
    
    func color(forKey key: String) -> UIColor? {
        if let binaryData = data(forKey: key){
            if let color = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: binaryData){
                return color
            }
        }
        return nil 
    }
    
    
}

