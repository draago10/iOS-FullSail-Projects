//
//  GroceryCell.swift
//  WendelDaniel_CE06
//
//  Created by Daniel Wendel on 5/14/21.
//

import UIKit

class GroceryCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var numberOfItems: UILabel!
    
    

}
