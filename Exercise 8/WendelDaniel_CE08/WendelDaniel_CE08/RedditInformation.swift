//
//  RedditInformation.swift
//  WendelDaniel_CE04
//
//  Created by Daniel Wendel on 5/10/21.
//

import UIKit
class Reddit {
    var title: String
    var author: String
    var subReddit: String
    var image: UIImage!
    
    init() {
        title = "No title"
        image = nil
        author = "N/A"
        subReddit = ""
    }
    
    init(title: String, author: String, subReddit: String, image: String) {
        self.title = title
        self.author = author
        self.subReddit = subReddit
        if let url = URL(string: image){
            do {
                let data = try Data(contentsOf: url)
                self.image = UIImage(data: data)
            }catch {
                print(error.localizedDescription)
            }
        }
    }
}
