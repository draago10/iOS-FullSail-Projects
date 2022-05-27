//
//  CongressMember.swift
//  WendelDaniel_CE05
//
//  Created by Daniel Wendel on 5/13/21.
//

import UIKit
class CongressPersonal {
    var id : String
    var firstName : String
    var lastName : String
    var party : String
    var stateOfResidence : String
    var image : UIImage?
    var title : String
    var facebook : String
    var twitter: String
    
    
    var fullName : String {
        return "\(firstName) \(lastName)"
    }
    
    init (id: String, firstName: String, lastName: String, party: String, stateOfRes: String, image: String, title: String, facebook: String, twitter: String){
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.party = party
        self.stateOfResidence = stateOfRes
        self.title = title
        self.facebook = facebook
        self.twitter = twitter
        
        //pull image from URL
        if image.contains("http"),
           let url = URL(string: image),
           var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false){
            urlComponents.scheme = "https"
            
            if let secureURL = urlComponents.url{
                do{
                    let data = try Data(contentsOf: secureURL)
                    self.image = UIImage(data: data)
                }
                catch{
                    print("IMAGE ERROR: \(error.localizedDescription)")
                }
            }
        }
        
    }
    
    init(){
        self.id = ""
        self.firstName = ""
        self.lastName = ""
        self.party = ""
        self.stateOfResidence = ""
        self.title = ""
        self.facebook = ""
        self.twitter = ""
    }
    
}
