//
//  ViewController.swift
//  WendelDaniel_CE07
//
//  Created by Daniel Wendel on 5/17/21.
//

import UIKit

private let cellId = "cellId"

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var searchedCitys = [State]()

    
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        navigationItem.title = "Search Results: " + searchedCitys.count.description
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableViewOutlet.reloadData()
        navigationItem.title = "Search Results: " + searchedCitys.count.description
        print(searchedCitys.count)
    }
    
    
    @IBAction func clearButton(_ sender: Any) {
        searchedCitys.removeAll()
        tableViewOutlet.reloadData()
        navigationItem.title = "Search Results: " + searchedCitys.count.description
    }

    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedCitys.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = searchedCitys[indexPath.row].cityName + ", " + searchedCitys[indexPath.row].state
        cell.detailTextLabel?.text = "Population: " + searchedCitys[indexPath.row].population.description
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SearchTableViewController{
            destination.firstVC = self
            destination.searchedList = searchedCitys
        }
        
    }
}

