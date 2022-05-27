//
//  VCExtension.swift
//  WendelDaniel_FinalSynthesis
//
//  Created by Daniel Wendel on 5/23/21.
//

import UIKit

extension LoadViewController{
    func pullFromApi(url: String){
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        
        if let validUrl = URL(string: url){
            var request = URLRequest(url: validUrl)
            
            
            request.httpMethod = "GET"
            
            let task = session.dataTask(with: request) { data, response, error in
                if let error = error{
                    print("Something bad happened: \(error.localizedDescription)")
                    return
                }
               
                
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200,
                      let validData = data
                else {print("Failed to create JSON"); return}
                
                do{
                    DispatchQueue.main.async {
                        self.activityIndicator.isHidden = false
                        self.activityIndicator.startAnimating()
                    }
                    
                    if let jsonObj = try JSONSerialization.jsonObject(with: validData, options: .mutableContainers) as? [String: Any]{
                        
                        //Different categories
                        var general = [Source]()
                        var technology = [Source]()
                        var sports = [Source]()
                        var business = [Source]()
                        var entertainment = [Source]()
                        var science = [Source]()
                        
                        var newSource = Source()
                        guard let sources = jsonObj["sources"] as? [[String : Any]] else {return}
                        
                        for source in sources{
                            guard let name = source["name"] as? String,
                                  let description = source["description"] as? String,
                                  let url = source["url"] as? String ,
                                  let category = source["category"] as? String,
                                  let language = source["language"] as? String,
                                  let country = source["country"] as? String,
                                  let id = source["id"] as? String
                                  else {continue}
                                
                            switch category {
                            case "general":
                                newSource = Source(sourceName: name, description: description, url: url, category: category, language: language, country: country, id: id)
                                general.append(newSource)
                            case "technology":
                                newSource = Source(sourceName: name, description: description, url: url, category: category, language: language, country: country, id: id)
                                technology.append(newSource)
                            case "sports":
                                newSource = Source(sourceName: name, description: description, url: url, category: category, language: language, country: country, id: id)
                                sports.append(newSource)
                            case "business":
                                newSource = Source(sourceName: name, description: description, url: url, category: category, language: language, country: country, id: id)
                                business.append(newSource)
                            case "entertainment":
                                newSource = Source(sourceName: name, description: description, url: url, category: category, language: language, country: country, id: id)
                                entertainment.append(newSource)
                            case "science":
                                newSource = Source(sourceName: name, description: description, url: url, category: category, language: language, country: country, id: id)
                                science.append(newSource)
                            default:
                                print("problems have arised")
                            }
                        }
                        
                        self.articleData.append(general)
                        self.articleData.append(technology)
                        self.articleData.append(science)
                        self.articleData.append(sports)
                        self.articleData.append(entertainment)
                        self.articleData.append(business)
                        
                        

                    }

                }catch{
                    
                    print(error.localizedDescription)
                }
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.performSegue(withIdentifier: "goToSourceView", sender: nil)
                }
                
            }
            task.resume()
        }
       
    }
}
