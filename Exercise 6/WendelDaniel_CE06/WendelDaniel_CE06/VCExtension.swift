//
//  VCExtension.swift
//  WendelDaniel_CE06
//
//  Created by Daniel Wendel on 5/14/21.
//

import UIKit

extension ViewController{
    func accessJson(){
        //Create the path to the json file
        if let path = Bundle.main.path(forResource: "GroceryList", ofType: ".json") {
            //Convert the file into a URL
            let url = URL(fileURLWithPath: path)
            
            //Do/Catch is used to check if the data being pulled exist, if it does not it will throw and error.
            do{
                //Save the URL to a "Data" type
                let data = try Data.init(contentsOf: url)
                //Serialize the data
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any]
                //Function to get all of the jsons data
                guard let groceryItems = jsonObj else {return}
                for item in groceryItems{
                    guard let groceryItem = item as? [String : Any],
                          let itemsNeeded = groceryItem["itemsneeded"] as? [String],
                          let purchasedItems = groceryItem["purchaseditems"] as? [String],
                          let storeName = groceryItem["storename"] as? String
                          else {return}
                    
                    
                        
                    let newStore = GroceryStore(storeName: storeName, itemsNeeded: itemsNeeded, purchasedItems: purchasedItems)
                    self.stores.append(newStore)
                    
                }
            } catch {
                print(error.localizedDescription)
            }
            tableView.reloadData()
        }
    }
    
    
    func createNewStore(storeName: String){
        let newStore = GroceryStore(storeName: storeName, itemsNeeded: [String](), purchasedItems: [String]())
        stores.append(newStore)
    }
}
