//
//  VCExtension.swift
//  WendelDaniel_CE04
//
//  Created by Daniel Wendel on 5/10/21.
//

import UIKit

extension ViewController{
    //MARK: JSON PULL METHOD
    func pullJsonData(jsonURL: String){
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        if let validURL = URL(string: jsonURL){
            let task = session.dataTask(with: validURL) { data, response, error in
                if let error = error{
                    print("Failed with error: \(error)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200,
                      let validData = data
                else {print("Failed to create json"); return}
                
                do {
                    
                    if let jsonObj = try JSONSerialization.jsonObject(with: validData, options: .mutableContainers) as? [String : Any],
                       let data = jsonObj["data"] as? [String : Any],
                       let children = data["children"] as? [[String : Any]]{
                        for child in children{
                            guard let childData = child["data"] as? [String : Any],
                                  let title = childData["title"] as? String
                                  else {continue}
                            
                            var newRedditData = Reddit()
                            if let image = childData["thumbnail"] as? String{
                                if image == "self"{
                                    print("No Image available")
                                }else{
                                    newRedditData = Reddit(title: title, image: image)
                                    self.redditData.append(newRedditData)
                                }
                            }
                        }
                        
                    }
                    
                }catch{
                    print(error.localizedDescription)
                }
                DispatchQueue.main.async {
                    self.dogeCoinRedditTableView.reloadData()
                }
                
            }
            task.resume()
        }
    }

}

