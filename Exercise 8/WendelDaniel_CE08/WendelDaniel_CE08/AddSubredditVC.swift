//
//  AddSubredditVC.swift
//  WendelDaniel_CE08
//
//  Created by Daniel Wendel on 5/18/21.
//

import UIKit

class AddSubredditVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var mainVc = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRedditTableView.allowsMultipleSelectionDuringEditing = true
        addRedditTableView.delegate = self
        addRedditTableView.dataSource = self
        subredditTextField.delegate = self
        addButtonOutlet.isHidden = true
        addRedditTableView.reloadData()
        setupUI()
        
    }
    @IBOutlet weak var addRedditTableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var addSubredditLabel: UILabel!
    @IBOutlet weak var subredditTextField: UITextField!
    @IBOutlet weak var addButtonOutlet: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainVc.subredditHeaders.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addSubredditCell", for: indexPath)
        cell.textLabel?.text = mainVc.subredditHeaders[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 25)
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let input = textField.text?.lowercased()
        textField.text = input?.replacingOccurrences(of: " ", with: "")
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if subredditTextField.text?.isEmpty == true{
            addButtonOutlet.isHidden = true
        }else{
            addButtonOutlet.isHidden = false
        }
    }
    
    @IBAction func editTapped(_ sender: Any) {
        addRedditTableView.setEditing(!addRedditTableView.isEditing, animated: true)
        if addRedditTableView.isEditing == true{
            editButton.title = "Back"
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(trashTapped))
            
        } else {
            editButton.title = "Edit"
            navigationItem.leftBarButtonItem = nil
        }
    }
    
    @objc func trashTapped(){
        if var selectedIP = addRedditTableView.indexPathsForSelectedRows{
            selectedIP.sort { a, b in a.row > b.row}
            for indexPath in selectedIP{
                for var subreddit in self.mainVc.redditData{
                    for x in (0..<subreddit.count).reversed(){
                        subreddit.remove(at: x)
                    }
                }
                mainVc.subredditHeaders.remove(at: indexPath.row)
                UserDefaults.standard.set(self.mainVc.subredditHeaders, forKey: "subreddit")
                self.mainVc.redditData.remove(at: indexPath.row)
            }
            self.mainVc.dogeCoinRedditTableView.reloadData()
            addRedditTableView.deleteRows(at: selectedIP, with: .left)
            addRedditTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let alert = UIAlertController(title: "Delete?", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { a in
                for var subreddit in self.mainVc.redditData{
                    for x in (0..<subreddit.count).reversed(){
                        subreddit.remove(at: x)
                    }
                }
                self.mainVc.redditData.remove(at: indexPath.row)
                //remove the title of the subreddit
                self.mainVc.subredditHeaders.remove(at: indexPath.row)
                UserDefaults.standard.set(self.mainVc.subredditHeaders, forKey: "subreddit")
                //update the tableview in the edit VC
                self.addRedditTableView.deleteRows(at: [indexPath], with: .left)
            }
            let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alert.addAction(deleteAction)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
            
        }
        addRedditTableView.reloadData()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let subreddit = subredditTextField.text else {return}
        let title = subreddit.lowercased().replacingOccurrences(of: " ", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
        
        if title == "dogecoin" || title == "bitcoin" || title == "etherum" || title == "binance coin" || title == "Tether" || title == "Cardano" || title == "Ripple" || title == "litecoin" || title == "Stellar" {
            mainVc.subredditHeaders.append(subreddit.lowercased())
            UserDefaults.standard.set(self.mainVc.subredditHeaders, forKey: "subreddit")
            mainVc.pullJsonData(jsonURL: "https://www.reddit.com/r/\(subreddit).json")
            subredditTextField.text = ""
            addRedditTableView.reloadData()
        }else{
            let alert = UIAlertController(title: "Not a crypto! (or a top crypto)", message: "What you entered is not a crypto (or a top crypto). You will see \(subreddit)(s) in your feed!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true) {
                self.mainVc.subredditHeaders.append(subreddit.lowercased())
                UserDefaults.standard.set(self.mainVc.subredditHeaders, forKey: "subreddit")
                self.mainVc.pullJsonData(jsonURL: "https://www.reddit.com/r/\(subreddit).json")
                self.subredditTextField.text = ""
                self.addRedditTableView.reloadData()
                
                print(self.mainVc.redditData.count)
            }
        }
        
    
    }
    
    
    func setupUI(){

        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        addRedditTableView.translatesAutoresizingMaskIntoConstraints = false
        addRedditTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        addRedditTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        addRedditTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        addRedditTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35).isActive = true
        addRedditTableView.separatorStyle = .singleLine
        addRedditTableView.separatorColor = .white
        addRedditTableView.backgroundColor = .clear
        
        addSubredditLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubredditLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addSubredditLabel.topAnchor.constraint(equalTo: addRedditTableView.bottomAnchor, constant: 10).isActive = true
        addSubredditLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90).isActive = true
        addSubredditLabel.textAlignment = .center
        
        subredditTextField.translatesAutoresizingMaskIntoConstraints = false
        subredditTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90).isActive = true
        subredditTextField.topAnchor.constraint(equalTo: addSubredditLabel.bottomAnchor, constant: 15).isActive = true
        subredditTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        addButtonOutlet.translatesAutoresizingMaskIntoConstraints = false
        addButtonOutlet.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addButtonOutlet.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        addButtonOutlet.heightAnchor.constraint(equalToConstant: 60).isActive = true
        addButtonOutlet.topAnchor.constraint(equalTo: subredditTextField.bottomAnchor, constant: 15).isActive = true
        addButtonOutlet.layer.cornerRadius = 10
    }
}
