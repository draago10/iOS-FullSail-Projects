//
//  CreateProfile.swift
//  WendelDanielAdaptiveLayoutProject
//
//  Created by Daniel Wendel on 6/21/21.
//

import UIKit
import CoreData
class CreateProfile: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.delegate = self
        saveButtonOutlet.isEnabled = false
    }
    
    @IBOutlet weak var saveButtonOutlet: UIButton!
    
    
    
    var player : Player?
    
    var managedContext: NSManagedObjectContext!
    var entityDescription: NSEntityDescription!
    var scoreboard: NSManagedObject!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.text?.isEmpty == true{
            saveButtonOutlet.isEnabled = false
        }
        return true
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text != nil {
            saveButtonOutlet.isEnabled = true
        }
    }

    
    func createPlayer() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        guard let userName = userNameTextField.text else {return}
        let newPlayer = Player(context: context)
        newPlayer.playerName = userName
        newPlayer.dateCompleted = Date()
        newPlayer.tapsToComplete = 0
        newPlayer.timeToComplete = 0
        player = newPlayer
        
        do {
            try context.save()
            print("saved!")
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
    @IBAction func goBack(sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
}
