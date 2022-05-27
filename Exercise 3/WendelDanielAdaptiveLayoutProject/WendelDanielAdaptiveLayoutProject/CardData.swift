//
//  CardData.swift
//  WendelDanielAdaptiveLayoutProject
//
//  Created by Daniel Wendel on 6/7/21.
//

import UIKit

class CardData {
    static func getAllCards() -> [Card]{
        let allCards =
            [
                Card(cardImage: UIImage(named: "basketBall"), backImage: <#T##UIImage?#>),
                Card(cardImage: UIImage(named: "bowArrow")),
                Card(cardImage: UIImage(named: "car")),
                Card(cardImage: UIImage(named: "catHearts")),
                Card(cardImage: UIImage(named: "coin")),
                Card(cardImage: UIImage(named: "computer")),
                Card(cardImage: UIImage(named: "dog")),
                Card(cardImage: UIImage(named: "earth")),
                Card(cardImage: UIImage(named: "fish")),
                Card(cardImage: UIImage(named: "heart"))
//                Card(cardImage: UIImage(named: "house")),
//                Card(cardImage: UIImage(named: "keyboard")),
//                Card(cardImage: UIImage(named: "lightBulb")),
//                Card(cardImage: UIImage(named: "lion")),
//                Card(cardImage: UIImage(named: "mail"))
            ]
        
        return allCards
    }
}
