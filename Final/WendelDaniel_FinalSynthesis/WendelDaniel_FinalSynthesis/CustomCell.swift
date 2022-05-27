//
//  CustomCell.swift
//  WendelDaniel_FinalSynthesis
//
//  Created by Daniel Wendel on 5/23/21.
//

import UIKit

class CustomCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var sourceName: UILabel!
    
    
}
