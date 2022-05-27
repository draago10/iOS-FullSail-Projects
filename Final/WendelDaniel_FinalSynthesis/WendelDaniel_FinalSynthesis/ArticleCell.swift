//
//  ArticleCell.swift
//  WendelDaniel_FinalSynthesis
//
//  Created by Daniel Wendel on 5/25/21.
//

import UIKit

class ArticleCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    
    func setupCell(){
        title.translatesAutoresizingMaskIntoConstraints = false
        title.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25).isActive = true
        title.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.50).isActive = true
        title.numberOfLines = 0
        
        articleImage.translatesAutoresizingMaskIntoConstraints = false
        articleImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        articleImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.40).isActive = true
        articleImage.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        articleImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
    }
    
}
