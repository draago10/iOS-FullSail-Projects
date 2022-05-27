//
//  CompanyInformation.swift
//  WendelDaniel_CE03
//
//  Created by Daniel Wendel on 5/6/21.
//

import UIKit
class CompanyInformation{
    var catchPhrase : String
    var colors : [Color]
    var dailyRevenue : String
    
    
    init(catchPhrase: String, color: [Color], dailyRevenue: String) {
        self.catchPhrase = catchPhrase
        self.colors = color
        self.dailyRevenue = dailyRevenue
    }
    
    init() {
        catchPhrase = "Default"
        colors = []
        dailyRevenue = "Default"
    }
    
}



