//
//  PlayerNameViewController.swift
//  WendelDaniel_RPS_MCProject
//
//  Created by Daniel Wendel on 6/18/21.
//

import UIKit

class PlayerNameViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.delegate = self
        
    }
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var saveButtonOutlet: UIButton!
    var chosenUserName = ""
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGame"{
            if let destinationVc = segue.destination as? ViewController{
                destinationVc.userName = chosenUserName
            }
        }
    }
    
    
    @IBAction func saveTapped(_ sender: Any) {
        let randomNumber = Int.random(in: 0...10)
        if userNameTextField.text?.isEmpty == true{
            chosenUserName = "Default \(randomNumber)"
            performSegue(withIdentifier: "goToGame", sender: sender)
        } else{
            chosenUserName = userNameTextField.text!
            print(chosenUserName)
            performSegue(withIdentifier: "goToGame", sender: sender)
        }
    }
    
}
