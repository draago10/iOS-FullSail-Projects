//
//  SettingsView.swift
//  WendelDaniel_CE08
//
//  Created by Daniel Wendel on 5/18/21.
//

import UIKit

class SettingsView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let editOptions = ["Title", "Author", "View"]
    var mainVc = ViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eidtOptionsTableView.delegate = self
        eidtOptionsTableView.dataSource = self
        setupUI()
    }
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var sliderContainerView: UIView!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var eidtOptionsTableView: UITableView!
    
    var redV : Float?
    var greenV : Float?
    var blueV : Float?
    
    var selectedCell : UITableViewCell?
    
    var selectedItem : String?
    
    var titleColor : UIColor?
    var authorColor : UIColor?
    var viewColor : UIColor?
    
    var newColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
    @IBAction func changeColor (sender: UISlider){
        redV = redSlider.value
        greenV = greenSlider.value
        blueV = blueSlider.value
        
        if let r = redV, let g = greenV, let b = blueV {
            view.backgroundColor = UIColor(displayP3Red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1)
            newColor = UIColor(displayP3Red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1)
            if selectedCell != nil {
                selectedCell?.textLabel?.textColor = newColor
            }
            
            if let cell = selectedCell{
                if cell.textLabel?.text == "Title"{
                    titleColor = cell.textLabel?.textColor
                }else if cell.textLabel?.text == "Author"{
                    authorColor = cell.textLabel?.textColor
                }else{
                    viewColor = cell.textLabel?.textColor
                }
            }
            
        }
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        UserDefaults.standard.set(color: titleColor ?? UIColor.white, forKey: "titleColor")
        UserDefaults.standard.set(color: authorColor ?? UIColor.white, forKey: "authorColor")
        UserDefaults.standard.set(color: viewColor ?? UIColor.clear, forKey: "viewColor")
        mainVc.authorColor = authorColor ?? UIColor.white
        mainVc.titleColor = titleColor ?? UIColor.white
        mainVc.viewColor = viewColor ?? UIColor.clear
        let alert = UIAlertController(title: "Saved!", message: "Saved new color theme", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func resetTapped(_ sender: Any) {
        
        UserDefaults.standard.set(color: titleColor ?? UIColor.white, forKey: "titleColor")
        UserDefaults.standard.set(color: authorColor ?? UIColor.white, forKey: "authorColor")
        UserDefaults.standard.set(color: viewColor ?? UIColor.clear, forKey: "viewColor")
        mainVc.authorColor =  UIColor.white
        mainVc.titleColor = UIColor.white
        mainVc.viewColor = UIColor.clear
        let red = 1.0
        let blue = 1.0
        let green = 1.0
        
        redV = Float(red)
        blueV = Float(blue)
        greenV = Float(green)
        
        if let r = redV, let g = greenV, let b = blueV {
            redSlider.value = r
            greenSlider.value = g
            blueSlider.value = b
            newColor = UIColor(displayP3Red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1)
            selectedCell?.textLabel?.textColor = newColor
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return editOptions.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath){
            selectedCell = cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = editOptions[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        //cell.contentView.backgroundColor = .black
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
    func setupUI(){
        eidtOptionsTableView.translatesAutoresizingMaskIntoConstraints = false
        eidtOptionsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        eidtOptionsTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true
        eidtOptionsTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45).isActive = true
        eidtOptionsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        eidtOptionsTableView.separatorColor = .white
        
        
        sliderContainerView.translatesAutoresizingMaskIntoConstraints = false
        sliderContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sliderContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true
        sliderContainerView.bottomAnchor.constraint(equalTo: toolBar.topAnchor, constant: -15).isActive = true
        sliderContainerView.topAnchor.constraint(equalTo: eidtOptionsTableView.bottomAnchor, constant: 15).isActive = true
        
        redSlider.translatesAutoresizingMaskIntoConstraints = false
        greenSlider.translatesAutoresizingMaskIntoConstraints = false
        blueSlider.translatesAutoresizingMaskIntoConstraints = false
        redSlider.topAnchor.constraint(equalTo: sliderContainerView.topAnchor, constant: 40).isActive = true
        redSlider.centerXAnchor.constraint(equalTo: sliderContainerView.centerXAnchor).isActive = true
        redSlider.widthAnchor.constraint(equalTo: sliderContainerView.widthAnchor, multiplier: 0.95).isActive = true
        redSlider.tintColor = .red
        redSlider.thumbTintColor = .red
        
        greenSlider.topAnchor.constraint(equalTo: redSlider.bottomAnchor, constant: 40).isActive = true
        greenSlider.centerXAnchor.constraint(equalTo: sliderContainerView.centerXAnchor).isActive = true
        greenSlider.widthAnchor.constraint(equalTo: sliderContainerView.widthAnchor, multiplier: 0.95).isActive = true
        greenSlider.tintColor = .green
        greenSlider.thumbTintColor = .green
        
        blueSlider.topAnchor.constraint(equalTo: greenSlider.bottomAnchor, constant: 40).isActive = true
        blueSlider.centerXAnchor.constraint(equalTo: sliderContainerView.centerXAnchor).isActive = true
        blueSlider.widthAnchor.constraint(equalTo: sliderContainerView.widthAnchor, multiplier: 0.95).isActive = true
        blueSlider.tintColor = .blue
        blueSlider.thumbTintColor = .blue
        
        
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        toolBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        toolBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
        toolBar.isTranslucent = true
        toolBar.backgroundColor = .black
        toolBar.barTintColor = .clear
    }
    
}
