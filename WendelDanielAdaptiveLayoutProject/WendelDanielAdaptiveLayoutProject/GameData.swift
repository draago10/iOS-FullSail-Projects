//
//  GameData.swift
//  WendelDanielAdaptiveLayoutProject
//
//  Created by Daniel Wendel on 6/21/21.
//

import Foundation
class GameData {
    var timeToComplete: String
    var tapsToComplete: Int
    var dateCompleted: Date
    
    
    init(timeToComplete: String, tapsToComplete: Int, dateCompleted: Date ){
        self.timeToComplete = timeToComplete
        self.tapsToComplete = tapsToComplete
        self.dateCompleted = dateCompleted
    }
    
//    init(){
//        self.timeToComplete = ""
//        self.tapsToComplete = 0
//        self.dateCompleted = Date()
//    }
}
