//
//  GroceryStore.swift
//  WendelDaniel_CE06
//
//  Created by Daniel Wendel on 5/14/21.
//

import UIKit

class GroceryStore {
    var storeName : String
    var itemsNeeded: [String]
    var purchasedItems : [String]
    
    
    var list : [[String]]{
        return [itemsNeeded, purchasedItems]
        
    }
    
    init(storeName : String, itemsNeeded: [String], purchasedItems : [String]) {
        self.storeName = storeName
        self.itemsNeeded = itemsNeeded
        self.purchasedItems = purchasedItems
        
    }
    
    
    init() {
        self.storeName = ""
        self.itemsNeeded = [String]()
        self.purchasedItems = [String]()
        
    }
}
