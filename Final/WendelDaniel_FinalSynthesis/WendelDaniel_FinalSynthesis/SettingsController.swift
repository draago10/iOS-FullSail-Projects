//
//  SettingsController.swift
//  WendelDaniel_FinalSynthesis
//
//  Created by Daniel Wendel on 5/25/21.
//

import UIKit

class SettingsController: UIViewController {

    var mainVc = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    var textColor : UIColor?
    var viewColor : UIColor?
    
    
    @IBOutlet weak var chooseThemeLabel: UILabel!
    @IBOutlet weak var darkModeOutlet: UIButton!
    @IBOutlet weak var redYellowOutlet: UIButton!
    @IBOutlet weak var readingModeOutlet: UIButton!
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBAction func themeSelected(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            textColor = darkModeOutlet.titleLabel?.textColor
            viewColor = darkModeOutlet.backgroundColor
        case 1:
            textColor = redYellowOutlet.titleLabel?.textColor
            viewColor = redYellowOutlet.backgroundColor
        case 2:
            textColor = readingModeOutlet.titleLabel?.textColor
            viewColor = readingModeOutlet.backgroundColor
        default:
            print("Shallent be here")
        }
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        UserDefaults.standard.set(color: textColor ?? UIColor.black, forKey: "textColor")
        UserDefaults.standard.set(color: viewColor ?? UIColor.white, forKey: "viewColor")
        mainVc.textColor = textColor ?? UIColor.black
        mainVc.viewColor = viewColor ?? UIColor.white
        let alert = UIAlertController(title: "Saved!", message: "Saved new color theme ✌️", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        mainVc.sourceTableViewOutlet.reloadData()
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func resetTapped(_ sender: Any) {
        textColor = UIColor.black
        viewColor = UIColor.white
        UserDefaults.standard.set(color: textColor ?? UIColor.black, forKey: "textColor")
        UserDefaults.standard.set(color: viewColor ?? UIColor.white, forKey: "viewColor")
        mainVc.textColor = textColor ?? UIColor.black
        mainVc.viewColor = viewColor ?? UIColor.white
        let alert = UIAlertController(title: "Reset!", message: "Reset the color theme to the default colors ✌️", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        mainVc.sourceTableViewOutlet.reloadData()
        present(alert, animated: true, completion: nil)
    }
    
    
    func setLayer(buttons: [UIButton?]){
        for button in buttons{
            button?.layer.shadowColor = UIColor.black.cgColor
            button?.layer.shadowOpacity = 1
            button?.layer.shadowOffset = .zero
            button?.layer.shadowRadius = 10
            button?.layer.cornerRadius = 40
        }
    }
    
    
    
    func setupUI(){
        chooseThemeLabel.translatesAutoresizingMaskIntoConstraints = false
        chooseThemeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        chooseThemeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        
        let buttons = [darkModeOutlet, redYellowOutlet, readingModeOutlet]
        setLayer(buttons: buttons)
        
        let stackView = UIStackView(arrangedSubviews: [darkModeOutlet, redYellowOutlet, readingModeOutlet])
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 50
        stackView.topAnchor.constraint(equalTo: chooseThemeLabel.bottomAnchor, constant: 15).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90).isActive = true
        stackView.bottomAnchor.constraint(equalTo: toolBar.topAnchor, constant: -15).isActive = true

        toolBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        toolBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        toolBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
}
