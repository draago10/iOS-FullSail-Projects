//
//  PlayerInfoController.swift
//  WendelDanielAdaptiveLayoutProject
//
//  Created by Daniel Wendel on 6/21/21.
//

import UIKit

class PlayerInfoController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerInfoLabel.text = "Player Name: \(playerData?[0].playerName ?? "No Name Found")"
        playerDataTableView.delegate = self
        playerDataTableView.dataSource = self
        sortedPlayerData = playerData!
        sortedPlayerData.sort(by: {$0.timeToComplete < $1.timeToComplete})
    }
    
    
    let cellId = "CellId"
    var playerData: [Player]?
    var sortedPlayerData = [Player]()
    
    @IBAction func backTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
  
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    //UIELEMENTS
    @IBOutlet weak var playerInfoLabel: UILabel!
    @IBOutlet weak var playerDataTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedPlayerData.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        
        let gameData = sortedPlayerData[indexPath.row]
        if let date = gameData.dateCompleted{
            let numberOfTurns = gameData.tapsToComplete
            let timeToComplete = gameData.timeToComplete
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yy"
            let completedDate = dateFormatter.string(from: date)
            
            if gameData.timeToComplete == 0{
                cell.textLabel?.text = "New account created."
                cell.detailTextLabel?.text = "Creation Date: \(completedDate)"
                print("FIX ME")
            }else{
                
                cell.textLabel?.text = "Game completed in \(numberOfTurns) moves and in \(timeString(time: TimeInterval(timeToComplete)))."
                cell.detailTextLabel?.text = "Completed Date: " + completedDate
            }
            
        }
        
        return cell
    }
    
}
