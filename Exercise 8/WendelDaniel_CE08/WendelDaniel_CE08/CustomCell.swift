//
//  CustomCell.swift
//  WendelDaniel_CE04
//
//  Created by Daniel Wendel on 5/11/21.
//

import UIKit

class CustomCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let title:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userName:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    
    func setUpCell(){
        contentView.addSubview(title)
        contentView.addSubview(userName)
        contentView.addSubview(postImage)
        
        
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25).isActive = true
        title.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        title.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        userName.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5).isActive = true
        userName.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        userName.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        postImage.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 10).isActive = true
        postImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.75).isActive = true
        postImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.75).isActive = true
        postImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        postImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
}
