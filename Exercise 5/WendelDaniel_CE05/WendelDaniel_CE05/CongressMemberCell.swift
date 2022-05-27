//
//  CongressMemberCell.swift
//  WendelDaniel_CE05
//
//  Created by Daniel Wendel on 5/13/21.
//

import UIKit

class CongressMemberCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var congressMemberNAme: UILabel!
    @IBOutlet weak var congressMemberTitle: UILabel!
    @IBOutlet weak var congressMemberState: UILabel!
    @IBOutlet weak var congressMemberImage: UIImageView!
    
    func setupCell(){
        congressMemberNAme.translatesAutoresizingMaskIntoConstraints = false
        congressMemberNAme.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25).isActive = true
        congressMemberNAme.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        
        congressMemberTitle.translatesAutoresizingMaskIntoConstraints = false
        congressMemberTitle.topAnchor.constraint(equalTo: congressMemberNAme.bottomAnchor, constant: 15).isActive = true
        congressMemberTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        
        congressMemberState.translatesAutoresizingMaskIntoConstraints = false
        congressMemberState.topAnchor.constraint(equalTo: congressMemberTitle.bottomAnchor, constant: 10).isActive = true
        congressMemberState.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        
        congressMemberImage.translatesAutoresizingMaskIntoConstraints = false
        congressMemberImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        congressMemberImage.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        congressMemberImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
