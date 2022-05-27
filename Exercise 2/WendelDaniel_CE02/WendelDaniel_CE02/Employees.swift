//
//  Employees.swift
//  WendelDaniel_CE02
//
//  Created by Daniel Wendel on 5/4/21.
//

import Foundation
class Employee {
    var name : String
    var userName : String
    var macAddress : String
    var currentTitle : String
    var skills : [String]
    var pastEmployers : [PastEmployer]
    
    var numSkills : Int {
        return skills.count
    }
    
    var numPastEmployers : Int {
        return pastEmployers.count
    }
    
    
    init(name: String, userName: String, macAddress: String, currentTitle: String, skills: [String], pastEmployers: [PastEmployer]) {
        self.name = name
        self.userName = userName
        self.macAddress = macAddress
        self.currentTitle = currentTitle
        self.skills = skills
        self.pastEmployers = pastEmployers
    }
}
