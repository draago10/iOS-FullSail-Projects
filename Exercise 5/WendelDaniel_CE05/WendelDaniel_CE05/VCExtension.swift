//
//  VCExtension.swift
//  WendelDaniel_CE05
//
//  Created by Daniel Wendel on 5/11/21.
//

import UIKit

extension ViewController{
    
    func pullFromAPI(url: String, url2: String){
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        
        if let validURL = URL(string: url), let validUrl2 = URL(string: url2){
            var request = URLRequest(url: validURL)
            
            request.setValue(apiKey, forHTTPHeaderField: "X-API-Key")
            
            request.httpMethod = "GET"
            
            let task = session.dataTask(with: request) { data, response, error in
                if let error = error{
                    print(error.localizedDescription)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200,
                      let validData = data
                else {print("Failed to create json"); return}
                
                do {
                    
                    if let jsonObj = try JSONSerialization.jsonObject(with: validData, options: .mutableContainers) as? [String : Any],
                       let results = jsonObj["results"] as? [[String: Any]]{
                        //print(results)
                        for members in results{
                            guard let member = members["members"] as? [[String : Any]] else {continue}
                            for m in member{
                                guard let firstName = m["first_name"] as? String,
                                      let lastName = m["last_name"] as? String,
                                      let party = m["party"] as? String,
                                      let title = m["title"] as? String,
                                      let stateOfRedidence = m["state"] as? String,
                                      let id = m["id"] as? String,
                                      let facebook = m["facebook_account"] as? String,
                                      let twitter = m["twitter_account"] as? String
                                      else{continue}
                                print(results)
                                
                                var newRepublicans = CongressPersonal()
                                var newDemocrats = CongressPersonal()
                                var newId = CongressPersonal()
                                
                                if party == "R"{
                                    newRepublicans = CongressPersonal(id: id, firstName: firstName, lastName: lastName, party: party, stateOfRes: stateOfRedidence, image: self.getImageData(id: id), title: title, facebook: facebook, twitter: twitter)
                                    self.republicans.append(newRepublicans)
                                    print("REPUBLICANS: \(self.republicans.count)")
                                } else if party == "D" {
                                    newDemocrats = CongressPersonal(id: id, firstName: firstName, lastName: lastName, party: party, stateOfRes: stateOfRedidence, image: self.getImageData(id: id), title: title, facebook: facebook, twitter: twitter)
                                    self.democrats.append(newDemocrats)
                                    print("DEMS: \(self.democrats.count)")
                                }else {
                                    newId = CongressPersonal(id: id, firstName: firstName, lastName: lastName, party: party, stateOfRes: stateOfRedidence, image: self.getImageData(id: id), title: title, facebook: facebook, twitter: twitter)
                                    self.identityDemocracy.append(newId)
                                    print("ID: \(self.democrats.count)")
                                }
                            }
                            
                        }
                        
                        self.allMembers.append(self.republicans)
                        self.allMembers.append(self.democrats)
                        self.allMembers.append(self.identityDemocracy)
                        
                    }
                }catch{
                    print("ERROR: \(error.localizedDescription)")
                }
                
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                }
            }
            task.resume()
        }
        
    }
    
    func getImageData(id: String) -> String{
        return "https://theunitedstates.io/images/congress/225x275/\(id).jpg"
    }
}

