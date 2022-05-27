//
//  City.swift
//  WendelDaniel_CE07
//
//  Created by Daniel Wendel on 5/17/21.
//

import Foundation

class State{
    var cityName : String
    var coordinates: [Double]
    var population : Int
    var state : String
    var id : String
    
    
    init(cityName: String, coordinates: [Double], population: Int, state: String, id: String) {
        self.cityName = cityName
        self.coordinates = coordinates
        self.population = population
        self.state = state
        self.id = id
    }
    
}
