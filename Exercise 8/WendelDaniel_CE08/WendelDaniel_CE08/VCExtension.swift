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
                else {  print("Failed to create json"); return}
               
                do {
                    DispatchQueue.main.async {
                        self.activityIndicator.startAnimating()
                        self.toolBar.isHidden = true
                    }
                    if let jsonObj = try JSONSerialization.jsonObject(with: validData, options: .mutableContainers) as? [String : Any],
                       let data = jsonObj["data"] as? [String : Any],
                       let children = data["children"] as? [[String : Any]]{
                        var newRedditData = Reddit()
                        var redditArray = [Reddit]()
                        for child in children{
                            guard let childData = child["data"] as? [String : Any],
                                  let title = childData["title"] as? String,
                                  let author = childData["author"] as? String,
                                  let subReddit = childData["subreddit"] as? String
                                  else {continue}
                            if let image = childData["thumbnail"] as? String{
                                if image == "self"{
                                    print("No Image available")
                                }else{
                                    newRedditData = Reddit(title: title, author: author, subReddit: subReddit, image: image)
                                    redditArray.append(newRedditData)
                                }
                            }
                        }
                        self.redditData.append(redditArray)
                        print("HEADERS: " + self.subredditHeaders.count.description)
                    }
                    
                }catch{
                    print(error.localizedDescription)
                }
                DispatchQueue.main.async {
                    self.dogeCoinRedditTableView.reloadData()
                    self.activityIndicator.stopAnimating()
                    self.toolBar.isHidden = false
                    self.activityIndicator.isHidden = true
                }
                
            }
            task.resume()
        }
    }

}

