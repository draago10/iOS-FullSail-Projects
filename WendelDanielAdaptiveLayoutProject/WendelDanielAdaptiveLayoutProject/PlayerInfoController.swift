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
        playerInfoLabel.text = player?.name
        for data in player!.gameData{
            print(data.dateCompleted)
        }
    }
    
    
    let cellId = "CellId"
    var player: Player?
    
    @IBAction func backTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
  
    //UIELEMENTS
    @IBOutlet weak var playerInfoLabel: UILabel!
    @IBOutlet weak var playerDataTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return player!.gameData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CustomCell
        else{return tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)}
        
        cell.numberOfTurns.text = player!.gameData[indexPath.row].tapsToComplete.description
        cell.dateCompleted.text = player!.gameData[indexPath.row].dateCompleted.description
        cell.timeToComplete.text = player!.gameData[indexPath.row].timeToComplete.description
        
        return cell
    }
    
}
