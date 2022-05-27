//
//  VCExtension.swift
//  WendelDaniel_CE07
//
//  Created by Daniel Wendel on 5/17/21.
//

import UIKit

extension SearchTableViewController{
    func parseJsonData(){
        if let path = Bundle.main.path(forResource: "zips", ofType: ".json") {
            
            let url = URL(fileURLWithPath: path)
            
            do{
                
                let data = try Data.init(contentsOf: url)
                
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any]
                guard let object = jsonObj else {return}
                for item in object{
                    guard let city = item as? [String : Any],
                          let cityName = city["city"] as? String,
                          let coordinates = city["loc"] as? [Double],
                          let population = city["pop"] as? Int,
                          let state = city["state"] as? String,
                          let id = city["_id"] as? String
                          else {continue}
                    var locationData = [Double]()
                    
                    for c in coordinates{
                        locationData.append(c)
                    }
                    let newState = State(cityName: cityName, coordinates: locationData, population: population, state: state, id: id)
                    allStates.append(newState)
                }
            } catch {
                print(error.localizedDescription)
            }
            tableView.reloadData()
        }
    }
}
