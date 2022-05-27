//
//  ViewController.swift
//  WendelDaniel_CE04
//
//  Created by Daniel Wendel on 5/10/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 

    //ALL REDDIT DATA
    var redditData = [Reddit]()
    //RESUSE CELL
    var cellId = "cellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        dogeCoinRedditTableView.register(CustomCell.self, forCellReuseIdentifier: cellId)
        dogeCoinRedditTableView.dataSource = self
        dogeCoinRedditTableView.delegate = self
        setUpUI()
        pullJsonData(jsonURL: "https://www.reddit.com/r/dogecoin.json")
    }

    //MARK: UI ELEMENTS
    @IBOutlet weak var dogeCoinImage: UIImageView!
    @IBOutlet weak var dogeCoinRedditTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    //MARK: TABLEVIEW METHODS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return redditData.count
    }
   
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomCell
        cell.title.text = redditData[indexPath.row].title
        cell.image.image = redditData[indexPath.row].image
        cell.backgroundColor = .clear
        return cell
    }
    
    
    //MARK: UI LAYOUT CREATION
    func setUpUI(){
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        dogeCoinImage.translatesAutoresizingMaskIntoConstraints = false
        dogeCoinImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        dogeCoinImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dogeCoinImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        dogeCoinImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.80).isActive = true
        
        dogeCoinRedditTableView.translatesAutoresizingMaskIntoConstraints = false
        dogeCoinRedditTableView.topAnchor.constraint(equalTo: dogeCoinImage.bottomAnchor, constant: 15).isActive = true
        dogeCoinRedditTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        dogeCoinRedditTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        dogeCoinRedditTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        dogeCoinRedditTableView.separatorStyle = .singleLine
        dogeCoinRedditTableView.separatorColor = .white
        dogeCoinRedditTableView.backgroundColor = .clear
    }
    
}

