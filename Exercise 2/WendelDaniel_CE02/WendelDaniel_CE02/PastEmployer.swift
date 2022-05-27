//
//  PastEmployer.swift
//  WendelDaniel_CE02
//
//  Created by Daniel Wendel on 5/4/21.
//

import Foundation
class PastEmployer {
    var companyName: String
    var responsibilities: [String]
    
    var numResponsibilities : Int {
        return responsibilities.count
    }
    
    init(companyName: String, responsibilities: [String]) {
        self.companyName = companyName
        self.responsibilities = responsibilities
    }
}
