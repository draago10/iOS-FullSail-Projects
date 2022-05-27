//
//  Article.swift
//  WendelDaniel_FinalSynthesis
//
//  Created by Daniel Wendel on 5/24/21.
//

import UIKit

class Article{
    var author : String?
    var title : String?
    var description : String?
    var url: String?
    var urlToImage : UIImage?
    var publishedDate : String?
    
    
    init(author: String, title: String, description: String, url: String, urlToImage: String, publishedDate: String) {
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.publishedDate = publishedDate
        if urlToImage.contains("http"),
           let url = URL(string: urlToImage),
           var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false){
            urlComponents.scheme = "https"
            
            if let secureURL = urlComponents.url{
                do{
                    let data = try Data(contentsOf: secureURL)
                    self.urlToImage = UIImage(data: data)
                }
                catch{
                    print("IMAGE ERROR: \(error.localizedDescription)")
                }
            }
        }
    }
    
    init() {
        self.author = ""
        self.title = ""
        self.description = ""
        self.url = ""
        self.urlToImage = UIImage()
        self.publishedDate = ""
    }
}



