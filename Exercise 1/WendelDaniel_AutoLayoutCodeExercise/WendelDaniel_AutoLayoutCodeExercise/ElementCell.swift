//
//  ElementCell.swift
//  WendelDaniel_AutoLayoutCodeExercise
//
//  Created by Daniel Wendel on 5/31/21.
//

import UIKit

class ElementCell: UITableViewCell {

    
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var name: UILabel!
    
    func setupCell(symbol: String, name: String){
        self.symbol.text = symbol
        self.name.text = name
    }
}
