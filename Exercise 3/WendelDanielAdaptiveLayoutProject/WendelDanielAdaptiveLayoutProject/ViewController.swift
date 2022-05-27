//
//  ViewController.swift
//  WendelDanielAdaptiveLayoutProject
//
//  Created by Daniel Wendel on 6/4/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientColor(view: topView, color1: UIColor.customBlue, color2: UIColor.aquaBlue)
        createGradientColor(view: bottomView, color1: UIColor.customBlue, color2: UIColor.aquaBlue)
        setImages()
        setLayerForButtons(buttons: allButtons)
        
    }
    let clickSound = URL(fileURLWithPath: Bundle.main.path(forResource: "clickSound", ofType: "wav")!)
    
    var cardData = CardData.getAllCards()
    
    var allButtons = [UIButton]()
    var soundPlayer = AVAudioPlayer()
    var card1 : UIButton?
    var card2 : UIButton?
    
    //UIElements
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
 
    @IBOutlet weak var row0Button0: UIButton!
    @IBOutlet weak var row0Button1: UIButton!
    @IBOutlet weak var row0Button2: UIButton!
    @IBOutlet weak var row0Button3: UIButton!
    
    @IBOutlet weak var row1Button0: UIButton!
    @IBOutlet weak var row1Button1: UIButton!
    @IBOutlet weak var row1Button2: UIButton!
    @IBOutlet weak var row1Button3: UIButton!
    
    @IBOutlet weak var row2Button0: UIButton!
    @IBOutlet weak var row2Button1: UIButton!
    @IBOutlet weak var row2Button2: UIButton!
    @IBOutlet weak var row2Button3: UIButton!
    
    @IBOutlet weak var row3Button0: UIButton!
    @IBOutlet weak var row3Button1: UIButton!
    @IBOutlet weak var row3Button2: UIButton!
    @IBOutlet weak var row3Button3: UIButton!
    
    @IBOutlet weak var row4Button0: UIButton!
    @IBOutlet weak var row4Button1: UIButton!
    @IBOutlet weak var row4Button2: UIButton!
    @IBOutlet weak var row4Button3: UIButton!
    
    @IBOutlet weak var timerDisplay: UILabel!
    @IBOutlet weak var moveCounter: UILabel!
    
    
    
    //create function to set random images
    func setImages(){
        allButtons.append(row0Button0)
        allButtons.append(row0Button1)
        allButtons.append(row0Button2)
        allButtons.append(row0Button3)
        allButtons.append(row1Button0)
        allButtons.append(row1Button1)
        allButtons.append(row1Button2)
        allButtons.append(row1Button3)
        allButtons.append(row2Button0)
        allButtons.append(row2Button1)
        allButtons.append(row2Button2)
        allButtons.append(row2Button3)
        allButtons.append(row3Button0)
        allButtons.append(row3Button1)
        allButtons.append(row3Button2)
        allButtons.append(row3Button3)
        allButtons.append(row4Button0)
        allButtons.append(row4Button1)
        allButtons.append(row4Button2)
        allButtons.append(row4Button3)
        
        let totalButtons = allButtons.count
        var cardDataDuplicate = cardData
        let totalMatches = totalButtons / 2
        
        
        for i in 0..<totalMatches{
            cardDataDuplicate.append(cardData[i])
            
        }
        print(cardDataDuplicate.count)
        cardDataDuplicate.shuffle()
        
        
        var counter = 0
        for button in allButtons{
            button.setImage(cardDataDuplicate[counter].cardImage, for: .normal)
            counter += 1
            
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            
        }
    }
    
    func compareImages(image1: UIImage, image2: UIImage){
        if image1 == image2{
            print("Match")
            card1?.isHidden = true
            card2?.isHidden = true
        } else {
            print("no match")
        }
    }
    var buttonCount = 0
    
    @objc func buttonTapped(sender: UIButton) {
        if buttonCount == 0{
            card1 = sender
            
            buttonCount += 1
        }else if buttonCount > 0 {
            card2 = sender
            
            compareImages(image1: (card1?.currentImage!)!, image2: (card2?.currentImage!)!)
            buttonCount = 0
            
        }
        
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: clickSound)
            soundPlayer.play()
        } catch {
            print("File Error")
        }
    }
   
    
    
    func setLayerForButtons(buttons: [UIButton?]){
        for button in buttons{
            button?.layer.shadowColor = UIColor.black.cgColor
            button?.layer.shadowOpacity = 1
            button?.layer.shadowOffset = .zero
            button?.layer.shadowRadius = 4
            button?.layer.cornerRadius = 5
        }
    }
    
    func createGradientColor(view: UIView, color1: UIColor, color2: UIColor){
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
}

