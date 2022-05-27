//
//  ViewController.swift
//  WendelDaniel_CE03
//
//  Created by Daniel Wendel on 5/6/21.
//

import UIKit

class ViewController: UIViewController {
    
    var company = [Company]()
    var companyInfo = [CompanyInformation]()
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        accessJSON(url: "https://fullsailmobile.firebaseio.com/T1NVC.json", url2: "https://fullsailmobile.firebaseio.com/T2CRC.json")
        
    }
    
    
    
    let name : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let companyLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let version : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let catchPhrase : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let dailyRevenue : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let colorsTextView : UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.sizeToFit()
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.textColor = .black
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    
    let nextButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(goToNextCharacter), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let previous : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Previous", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(goToPreviousCharacter), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //UI BUTTON FUNCTIONALITY
    @objc func goToNextCharacter(){
        index += 1
        print(index)
        if index < company.count {
            displayUI()
        } else{
            index = 0
            displayUI()
        }
    }
    
    @objc func goToPreviousCharacter(){
        index -= 1
        print(index)
        if index < 0 {
            index = company.count - 1
            displayUI()
        } else {
            displayUI()
        }
    }
    
    func setUpUI(){
        view.addSubview(name)
        name.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        name.leftAnchor.constraint(equalTo: view.leftAnchor, constant:  25).isActive = true
        
        view.addSubview(companyLabel)
        companyLabel.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10).isActive = true
        companyLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant:  25).isActive = true
        
        view.addSubview(version)
        version.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 1).isActive = true
        version.leftAnchor.constraint(equalTo: view.leftAnchor, constant:  25).isActive = true
        
        view.addSubview(catchPhrase)
        catchPhrase.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        catchPhrase.topAnchor.constraint(equalTo: version.bottomAnchor, constant: 45).isActive = true
        catchPhrase.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        catchPhrase.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        view.addSubview(dailyRevenue)
        dailyRevenue.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dailyRevenue.topAnchor.constraint(equalTo: catchPhrase.bottomAnchor, constant: 25).isActive = true
        
        view.addSubview(colorsTextView)
        colorsTextView.topAnchor.constraint(equalTo: dailyRevenue.bottomAnchor, constant: 25).isActive = true
        colorsTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        colorsTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.80).isActive = true
        colorsTextView.heightAnchor.constraint(equalToConstant: 225).isActive = true
        
        
        view.addSubview(previous)
        previous.topAnchor.constraint(equalTo: colorsTextView.bottomAnchor, constant: 25).isActive = true
        previous.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 55).isActive = true
        previous.widthAnchor.constraint(equalToConstant: 125).isActive = true
        previous.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nextButton)
        nextButton.topAnchor.constraint(equalTo: colorsTextView.bottomAnchor, constant: 25).isActive = true
        nextButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -55).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        displayUI()
    }
    
    func displayUI(){
        name.text = company[index].name
        companyLabel.text = company[index].company
        version.text = company[index].version
        catchPhrase.text = companyInfo[index].catchPhrase
        dailyRevenue.text = "Daily Revenue: \(companyInfo[index].dailyRevenue)"
       
        let allColors = companyInfo[index].colors
        if allColors.isEmpty{
            print("empty")
        }else{
            var colors = ""
            for i in allColors{
                colors += "\(i.description)\t\t\t\(i.color)\n\n"
            }
            colorsTextView.text = colors
        }
         
    }
    
    func accessJSON(url: String, url2: String){
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        
        if let validURL = URL(string: url), let validUrl2 = URL(string: url2) {
            
            let task = session.dataTask(with: validURL) { data, response, error in
                if let error = error {
                    print("Task failed with error: \(error.localizedDescription)")
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200,
                      let validData = data
                else {print("failed to create json"); return}
                
                
                let task2 = session.dataTask(with: validUrl2) { data, response, error in
                    if let error = error {
                        print("Task failed with error: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let httpResponse = response as? HTTPURLResponse,
                          httpResponse.statusCode == 200,
                          let validData2 = data
                    else {print("failed to create json"); return}
                    
                    do {
                        let jsonObj = try JSONSerialization.jsonObject(with: validData, options: .mutableContainers) as? [Any]
                        let jsonObj2 = try JSONSerialization.jsonObject(with: validData2, options: .mutableContainers) as? [Any]
                        self.parseCompanyInformation(jsonObject: jsonObj, jsonObject2: jsonObj2)
                    }
                    catch{
                        print(error.localizedDescription)
                    }
                    
                }
                task2.resume()
            }
            task.resume()
            
        }
    }
    
    func parseCompanyInformation(jsonObject: [Any]?, jsonObject2: [Any]?){
        //Parse first url
        guard let json = jsonObject, let json2 = jsonObject2 else {print("failed to parse"); return}
        
        
        for items in json {
            guard let objects = items as? [String : Any],
                  let company = objects["company"] as? String,
                  let name = objects["name"] as? String,
                  let version = objects["version"] as? String else {continue}
            
            let newCompany = Company(company: company, name: name, version: version)
            
            self.company.append(newCompany)
            
            
            
            for items in json2{
                guard let objects = items as? [String : Any],
                      let catchPhrase = objects["catch_phrase"] as? String,
                      let colors = objects["colors"] as? [[String : Any]] else {continue}
                
                
                var colorArray = [Color]()
                
                for c in colors{
                    if let color = c["color"] as? String, let description = c["desription"] as? String{
                        let newColor = Color(description: description, color: color)
                        colorArray.append(newColor)
                    }
                }
                
                
                
                var companyInfo = CompanyInformation()
                if let  dailyRevenue = objects["daily_revene"] as? String {
                    companyInfo = CompanyInformation(catchPhrase: catchPhrase, color: colorArray, dailyRevenue: dailyRevenue)
                    
                } else {
                    companyInfo = CompanyInformation(catchPhrase: catchPhrase, color: colorArray, dailyRevenue: "No revenue reported")
                }
                
                self.companyInfo.append(companyInfo)
                
                
                
            }
            
            
        }
        
        
        DispatchQueue.main.async {
            self.setUpUI()
        }
    }
    
}

