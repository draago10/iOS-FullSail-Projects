//
//  SearchTableViewController.swift
//  WendelDaniel_CE07
//
//  Created by Daniel Wendel on 5/17/21.
//

import UIKit

private let cellId = "searchCellId"

class SearchTableViewController: UITableViewController,UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate, UITextFieldDelegate {

    
    var allStates = [State]()
    var filteredStates = [State]()
    var searchedList = [State]()
    var firstVC = ViewController()
    
    var searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        parseJsonData()
        filteredStates = allStates
        
    }
    
    func setupSearchController(){
        searchController.definesPresentationContext = true
        searchController.automaticallyShowsScopeBar = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.scopeButtonTitles = ["All","FL","GA"]
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }

    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        
        let selectedScope = searchController.searchBar.selectedScopeButtonIndex
        let allScopeTitles = searchController.searchBar.scopeButtonTitles!
        let scopeTitle = allScopeTitles[selectedScope]
        
        
        filteredStates = allStates
        
        if searchText != ""{
            filteredStates = filteredStates.filter({ state in
                return state.cityName.lowercased().range(of: searchText!.lowercased()) != nil})
        }
        
        if scopeTitle != "All"{
            filteredStates = filteredStates.filter({ $0.state.range(of: scopeTitle) != nil})
        }
        tableView.reloadData()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        updateSearchResults(for: searchController)
        print(filteredStates.count)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredStates.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = filteredStates[indexPath.row].cityName + ", " + filteredStates[indexPath.row].state
        cell.detailTextLabel?.text = "Population: " + filteredStates[indexPath.row].population.description
        return cell
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchText = searchController.searchBar.text
        searchedList = filteredStates
        if searchText != ""{
            filteredStates = filteredStates.filter({ state in
                return state.cityName.lowercased().range(of: searchText!.lowercased()) != nil})
        }
        firstVC.searchedCitys = searchedList
        navigationController?.popViewController(animated: true)
    }

}
