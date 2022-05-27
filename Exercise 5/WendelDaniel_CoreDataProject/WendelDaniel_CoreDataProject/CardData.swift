//
//  CardData.swift
//  WendelDanielAdaptiveLayoutProject
//
//  Created by Daniel Wendel on 6/7/21.
//

import UIKit

class CardData {
    static func cardsForIphone() -> [Card]{
        let iPhoneCards =
            [
                Card(backImage: UIImage(named: "basketBall"), frontImage: UIImage(named: "brain")),
                Card(backImage: UIImage(named: "bowArrow"), frontImage: UIImage(named: "brain")),
                Card(backImage: UIImage(named: "car"), frontImage: UIImage(named: "brain")),
                Card(backImage: UIImage(named: "catHearts"), frontImage: UIImage(named: "brain")),
                Card(backImage: UIImage(named: "coin"), frontImage: UIImage(named: "brain")),
                Card(backImage: UIImage(named: "computer"), frontImage: UIImage(named: "brain")),
                Card(backImage: UIImage(named: "dog"), frontImage: UIImage(named: "brain")),
                Card(backImage: UIImage(named: "earth"), frontImage: UIImage(named: "brain")),
                Card(backImage: UIImage(named: "fish"), frontImage: UIImage(named: "brain")),
                Card(backImage: UIImage(named: "heart"), frontImage: UIImage(named: "brain"))
            ]
        
        return iPhoneCards
    }
    
    static func cardsForIPad() -> [Card]{
        let iPadCards =
            [
                Card(backImage: UIImage(named: "basketBall"), frontImage: UIImage(named: "brain")),
                Card(backImage: UIImage(named: "bowArrow"), frontImage: UIImage(named: "brain")),
                Card(backImage: UIImage(named: "car"), frontImage: UIImage(named: "brain")),
                Card(backImage: UIImage(named: "catHearts"), frontImage: UIImage(named: "brain")),
                Card(backImage: UIImage(named: "coin"), frontImage: UIImage(named: "brain")),
                Card(backImage: UIImage(named: "computer"), frontImage: UIImage(named: "brain")),
                Card(backImage: UIImage(named: "dog"), frontImage: UIImage(named: "brain")),
                Card(backImage: UIImage(named: "earth"), frontImage: UIImage(named: "brain")),
                Card(backImage: UIImage(named: "fish"), frontImage: UIImage(named: "brain")),
                Card(backImage: UIImage(named: "heart"), frontImage: UIImage(named: "brain")),
                Card(backImage: UIImage(named: "monkey"), frontImage: UIImage(named: "brain")),
                Card(backImage: UIImage(named: "mountain"), frontImage: UIImage(named: "brain")),
                Card(backImage: UIImage(named: "mouse"), frontImage: UIImage(named: "brain")),
                Card(backImage: UIImage(named: "person"), frontImage: UIImage(named: "brain")),
                Card(backImage: UIImage(named: "shark"), frontImage: UIImage(named: "brain"))
            ]
        
        return iPadCards
    }
}
