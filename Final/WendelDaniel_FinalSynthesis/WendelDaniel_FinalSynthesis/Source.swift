//
//  NewsArticle.swift
//  WendelDaniel_FinalSynthesis
//
//  Created by Daniel Wendel on 5/23/21.
//

import UIKit

class Source {
    var sourceName : String?
    var description : String?
    var url : String?
    var category: String?
    var language: String?
    var country : String?
    var id : String?
    
    init(sourceName: String, description: String, url: String, category: String, language: String, country: String, id: String) {
        self.sourceName = sourceName
        self.description = description
        self.url = url
        self.category = category
        self.language = language
        self.country = country
        self.id = id
    }
    
    init() {
        self.sourceName = ""
        self.description = ""
        self.url = ""
        self.category = ""
        self.language = ""
        self.country = ""
        self.id = ""
    }
}
