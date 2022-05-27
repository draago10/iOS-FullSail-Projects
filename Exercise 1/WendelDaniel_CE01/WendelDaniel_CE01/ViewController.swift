//
//  ViewController.swift
//  WendelDaniel_CE01
//
//  Created by Daniel Wendel on 5/3/21.
//

import UIKit

class ViewController: UIViewController {
    
    //Empty character object array. To be filled once we have the data.
    var characters = [Character]()
    //Index to show the starting point of the characters. To be increased or decreased depending on the button clicked.
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        accessJson()
        setUpUI()
    }
    
    //UI ELEMENTS
    let characterIcon : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        return image
    }()
    
    
    let characterNameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let characterTextView : UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.sizeToFit()
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.textColor = .black
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    
    let nextCharacter : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(goToNextCharacter), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let previousCharacter : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Previous", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(goToPreviousCharacter), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //UI BUTTON FUNCTIONALITY
    @objc func goToNextCharacter(){
        index += 1
        if index < characters.count {
            characterIcon.image = characters[index].characterImage
            characterNameLabel.text = characters[index].fullName
            characterTextView.text = characters[index].getFullDescription()
            
            
        } else{
            index = 0
            characterIcon.image = characters[index].characterImage
            characterNameLabel.text = characters[index].fullName
            characterTextView.text = characters[index].getFullDescription()
        }
    }
    
    @objc func goToPreviousCharacter(){
        index -= 1
        if index < 0 {
            index = 9
            characterIcon.image = characters[index].characterImage
            characterNameLabel.text = characters[index].fullName
            characterTextView.text = characters[index].getFullDescription()
        } else {
            
            characterIcon.image = characters[index].characterImage
            characterNameLabel.text = characters[index].fullName
            characterTextView.text = characters[index].getFullDescription()
        }
    }
    //Display the initial UI
    func displayUI(){
        characterIcon.image = characters[index].characterImage
        characterNameLabel.text = characters[index].fullName
        characterTextView.text = characters[index].getFullDescription()
    }
    
    //MARK: SET UP UI
    func setUpUI(){
        
        view.addSubview(nextCharacter)
        nextCharacter.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        nextCharacter.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        
        view.addSubview(previousCharacter)
        previousCharacter.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        previousCharacter.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        
        view.addSubview(characterNameLabel)
        characterNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        characterNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        view.addSubview(characterIcon)
        characterIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        characterIcon.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.80).isActive = true
        characterIcon.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: 25).isActive = true
        characterIcon.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45).isActive = true
        
        view.addSubview(characterTextView)
        characterTextView.topAnchor.constraint(equalTo: characterIcon.bottomAnchor, constant: 15).isActive = true
        characterTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        characterTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90).isActive = true
        characterTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        
        displayUI()
    }
    
    //MARK: JSON METHODS
    func accessJson(){
        //Create the path to the json file
        if let path = Bundle.main.path(forResource: "Characters", ofType: ".json") {
            //Convert the file into a URL
            let url = URL(fileURLWithPath: path)
            
            //Do/Catch is used to check if the data being pulled exist, if it does not it will throw and error.
            do{
                //Save the URL to a "Data" type
                let data = try Data.init(contentsOf: url)
                //Serialize the data
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any]
                //Function to get all of the jsons data
                parseJson(jsonObject: jsonObj)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
    func parseJson(jsonObject: [Any]?){
        //Bind the json obj
        if let jsonObj = jsonObject {
            //Loop through all the items in the json object
            for items in jsonObj{
                
                guard let objects = items as? [String : Any],
                      let firstName = objects["firstName"] as? String,
                      let lastName = objects["lastName"] as? String,
                      let age = objects["age"] as? Int,
                      let weapon = objects["weapon"] as? [String],
                      let mainCharacter = objects["mainCharacter"] as? Bool,
                      let characterImage = objects["characterImage"] as? String,
                      let image = UIImage(named: characterImage),
                      let description = objects["description"] as? String else {return}
                
                
                //Construct a new character
                let newCharacter = Character(firstName: firstName, lastName: lastName, age: age, weapons: weapon, mainCharacter: mainCharacter, image: image , description: description)
                characters.append(newCharacter)
            }
        }
    }
    
    
}

