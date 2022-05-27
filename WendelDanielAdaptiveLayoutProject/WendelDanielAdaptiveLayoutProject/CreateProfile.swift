//
//  CreateProfile.swift
//  WendelDanielAdaptiveLayoutProject
//
//  Created by Daniel Wendel on 6/21/21.
//

import UIKit

class CreateProfile: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.delegate = self
    }
    var player: Player?
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func createPlayer() {
        let newPlayer = Player(name: userNameTextField.text!)
        player = newPlayer
        
    }
    
    
    @IBAction func goBack(sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
}
