//
//  ElementTableCell.swift
//  AdaptiveLayout_Lecture1_Complete


import Foundation
import UIKit

class ElementTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var m_symbol: UILabel!
    @IBOutlet weak var m_name: UILabel!
    
    
    func setupCell(_ symbol: String, name: String) {
        m_symbol.text = symbol
        m_name.text = name
    }
    
}
