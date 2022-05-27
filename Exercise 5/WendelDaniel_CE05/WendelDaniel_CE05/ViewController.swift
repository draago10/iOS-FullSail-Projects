//
//  ViewController.swift
//  WendelDaniel_CE05
//
//  Created by Daniel Wendel on 5/11/21.
//

import UIKit

class ViewController: UITableViewController {
    let apiKey = "viFibD09P9uSQxi57lgLB9UBWAFvHTxLBJKsXV52"
    
    var allMembers = [[CongressPersonal]]()
    var republicans = [CongressPersonal]()
    var democrats = [CongressPersonal]()
    var identityDemocracy = [CongressPersonal]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pullFromAPI(url: "https://api.propublica.org/congress/v1/116/senate/members.json", url2: "")
        
        
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return allMembers.count
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "Republicans"
        case 1:
            return "Democrats"
        case 2:
            return "Identity and Democracy Party"
        default:
            return "Invaid Section"
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allMembers[section].count
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? CongressMemberCell
        else {return tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)}
        
        let memberInfo = allMembers[indexPath.section][indexPath.row]
        cell.congressMemberNAme.text = memberInfo.fullName
        cell.congressMemberTitle.text = memberInfo.title
        cell.congressMemberState.text = "State: \(memberInfo.stateOfResidence)"
        
        if memberInfo.image != nil{
            cell.congressMemberImage.image = memberInfo.image
        }else{
            cell.congressMemberImage.image = UIImage(named: "noImg")
        }
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow{
            let memberInfo = allMembers[indexPath.section][indexPath.row]
            if let destination = segue.destination as? MemberDetailView{
                
                destination.member = memberInfo
            }
        }
    }
    
    
    
    
}

