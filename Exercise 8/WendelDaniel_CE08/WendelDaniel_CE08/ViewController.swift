//
//  ViewController.swift
//  WendelDaniel_CE04
//
//  Created by Daniel Wendel on 5/10/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 

    //ALL REDDIT DATA
    var redditData = [[Reddit]]()
    var subredditHeaders = [String]()
    
    var authorColor = UIColor.white
    var titleColor = UIColor.white
    var viewColor = UIColor.clear
    var defaults = UserDefaults.standard
    //RESUSE CELL
    var cellId = "cellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        dogeCoinRedditTableView.register(CustomCell.self, forCellReuseIdentifier: cellId)
        dogeCoinRedditTableView.dataSource = self
        dogeCoinRedditTableView.delegate = self
        navigationItem.title = "🚀Crypto Subreddit🚀"
        setUpUI()
        loadData()
        print(subredditHeaders.count)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if subredditHeaders.count == 0{
            alertLabel.isHidden = false
        }else {
            alertLabel.isHidden = true
        }
        dogeCoinRedditTableView.reloadData()
    }

    //MARK: UI ELEMENTS
    @IBOutlet weak var dogeCoinImage: UIImageView!
    @IBOutlet weak var dogeCoinRedditTableView: UITableView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var alertLabel: UILabel!
    
    
    
    
    
        //MARK: LOAD DATA
    func loadData(){
        self.redditData.removeAll()
        self.subredditHeaders.removeAll()
        if let redditHeaders = defaults.array(forKey: "subreddit") as? [String]{
            if redditHeaders.count >= 1{
                self.activityIndicator.isHidden = false
                self.subredditHeaders = redditHeaders
                print("TESTING: \(subredditHeaders.count)")
                for header in subredditHeaders{
                    pullJsonData(jsonURL: "https://www.reddit.com/r/\(header).json")
                }
                alertLabel.isHidden = true
                self.dogeCoinRedditTableView.reloadData()
            }else{
                alertLabel.isHidden = false
                alertLabel.text = "No Subreddits, click 'subreddits' below to add one."
                print("Nothing to load")
            }
           
        }
        if let titleColor = defaults.color(forKey: "titleColor"),
           let authorColor = defaults.color(forKey: "authorColor"),
           let viewColor = defaults.color(forKey: "viewColor"){
            self.titleColor = titleColor
            self.authorColor = authorColor
            self.viewColor = viewColor
        }
    }
    
    
    //MARK: TABLEVIEW METHODS
    func numberOfSections(in tableView: UITableView) -> Int {
        return redditData.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return redditData[section].count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return subredditHeaders[section]
    }

   
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomCell
        if titleColor == UIColor.white {
            cell.title.textColor = .white
        } else{
            cell.title.textColor = titleColor
        }
        if authorColor == UIColor.white {
            cell.userName.textColor = .white
        } else{
            cell.userName.textColor = authorColor
        }
        if viewColor == UIColor.clear {
            cell.backgroundColor = .clear
        } else{
            cell.backgroundColor = viewColor
        }
        cell.title.text = "Post: " + redditData[indexPath.section][indexPath.row].title
        cell.userName.text = "u/"+redditData[indexPath.section][indexPath.row].author
        cell.postImage.image = redditData[indexPath.section][indexPath.row].image
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSubreddit"{
            if let destination = segue.destination as? AddSubredditVC{
                destination.mainVc = self
            }
        }else if segue.identifier == "goToSettings"{
            if let destination = segue.destination as? SettingsView{
                destination.mainVc = self
            }
        }
    }
    
    
    func alertUser(){
        let alert = UIAlertController(title: "Invalid Input", message: "One of the saved/entered reddit pages is not a valid reddit page. Click the 'subreddit' button to delete the incorrect page.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: UI LAYOUT CREATION
    func setUpUI(){
        activityIndicator.color = .white
        activityIndicator.isHidden = true

           
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        dogeCoinImage.translatesAutoresizingMaskIntoConstraints = false
        dogeCoinImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        dogeCoinImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dogeCoinImage.heightAnchor.constraint(equalToConstant: 125).isActive = true
        dogeCoinImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.80).isActive = true
        
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
        alertLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        alertLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        alertLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90).isActive = true
        alertLabel.isHidden = true
        alertLabel.textAlignment = .center
        alertLabel.numberOfLines = 0
        
        dogeCoinRedditTableView.translatesAutoresizingMaskIntoConstraints = false
        dogeCoinRedditTableView.topAnchor.constraint(equalTo: dogeCoinImage.bottomAnchor, constant: 15).isActive = true
        dogeCoinRedditTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        dogeCoinRedditTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        dogeCoinRedditTableView.bottomAnchor.constraint(equalTo: toolBar.topAnchor).isActive = true
        dogeCoinRedditTableView.separatorStyle = .singleLine
        dogeCoinRedditTableView.separatorColor = .white
        dogeCoinRedditTableView.backgroundColor = .clear
        
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        toolBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        toolBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
        toolBar.isTranslucent = true
        toolBar.backgroundColor = .black
        toolBar.barTintColor = .clear
        
        
        
    }
    
}

