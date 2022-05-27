//
//  ViewController.swift
//  WendelDaniel_FinalSynthesis
//
//  Created by Daniel Wendel on 5/23/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var articleData = [[Source]]()
    var selectedArticle = [Article]()
    
    var textColor = UIColor.black
    var viewColor = UIColor.white
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        activityIndicator.style = .medium
        activityIndicator.color = textColor
        sourceTableViewOutlet.dataSource = self
        sourceTableViewOutlet.delegate = self
        loadTheme()
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedArticle.removeAll()
        loadTheme()
    }
    
    
    
    func loadTheme(){
        if let textColor = defaults.color(forKey: "textColor"),
           let viewColor = defaults.color(forKey: "viewColor"){
            self.textColor = textColor
            self.viewColor = viewColor
            self.view.backgroundColor = viewColor
        }
    }
    
    @IBOutlet weak var sourceTableViewOutlet: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return articleData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articleData[section].count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = articleData[indexPath.section][indexPath.row].id else {return}
        print(id)
        queryArticle(url: "https://newsapi.org/v1/articles?source=\(id)&apiKey=a0f095648a204e7aa900f16bfdf9c7ea")
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "General"
        case 1:
            return "Technology"
        case 2:
            return "Science"
        case 3:
            return "Sports"
        case 4:
            return "Entertainment"
        case 5:
            return "Business"
        default:
            return "Error"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CustomCell
        
        if textColor == UIColor.black{
            cell.sourceName.textColor = .black
        }else{
            cell.sourceName.textColor = textColor
        }
        
        if viewColor == UIColor.white{
            cell.backgroundColor = .white
        }else{
            cell.backgroundColor = viewColor
        }
        
        cell.sourceName.text = articleData[indexPath.section][indexPath.row].sourceName
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToArticle"{
            if let indexPath =  sourceTableViewOutlet.indexPathForSelectedRow{
                let sourceData = articleData[indexPath.section][indexPath.row]
                if let destination = segue.destination as? ArticlesTableView{
                    destination.articleData = selectedArticle
                    destination.sourceName = sourceData.sourceName ?? "No data"
                    destination.textColor = textColor
                    destination.viewColor = viewColor
                }
            }
        }else if segue.identifier == "goToSettings"{
            if let destination = segue.destination as? SettingsController{
                destination.mainVc = self
            }
        }
    }
    
    
    @IBAction func settingsTapped(_ sender: Any) {
        performSegue(withIdentifier: "goToSettings", sender: sender)
    }
    
    func queryArticle(url: String){
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
                        self.sourceTableViewOutlet.isHidden = true
                    }
                    
                    if let jsonObj = try JSONSerialization.jsonObject(with: validData, options: .mutableContainers) as? [String: Any]{
                        
                        guard let articles = jsonObj["articles"] as? [[String : Any]] else {return}
                        
                        var newArticle = Article()
                        for article in articles{
                            let author = article["author"] as? String ?? "No data"
                            let title = article["title"] as? String ?? "No Data"
                            let description = article["description"] as? String ?? "No Data"
                            let url = article["url"] as? String ?? "No Data"
                            let publishedDate = article["publishedAt"] as? String ?? "No Data"
                            if let urlToImage = article["urlToImage"] as? String{
                                newArticle = Article(author: author, title: title, description: description, url: url, urlToImage: urlToImage, publishedDate: publishedDate)
                            }
                            
                            self.selectedArticle.append(newArticle)
                        }
                    }
                    
                }catch{
                    
                    print(error.localizedDescription)
                }
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.sourceTableViewOutlet.isHidden = false
                    self.performSegue(withIdentifier: "goToArticle", sender: nil)
                }
                
            }
            task.resume()
            
            
        }
    }
}

