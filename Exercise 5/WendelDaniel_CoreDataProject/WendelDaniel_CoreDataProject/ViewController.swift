//
//  ViewController.swift
//  WendelDanielAdaptiveLayoutProject
//
//  Created by Daniel Wendel on 6/4/21.
//

import UIKit
import CoreData
import AVFoundation

class ViewController: UIViewController {
    let clickSound = URL(fileURLWithPath: Bundle.main.path(forResource: "clickSound", ofType: "wav")!)
    var buttonCount = 0
    var allButtons = [UIButton]()
    var iPhoneCardData = CardData.cardsForIphone()
    var iPadCardData = CardData.cardsForIPad()
    var cardImageDataDuplicate = [Card]()
    var matchedCards = [UIButton]()
    var cardMathces = [UIButton]()
    var soundPlayer = AVAudioPlayer()
    var timer : Timer? = nil
    var gameTimer = Timer()
    var timeCounter = 6
    var gameCounter = 0
    var moveCount = 0
    var card1 : UIButton?
    var card2 : UIButton?
    var player: Player?
    var playerData = [Player]()
    let context = CoreDataManager.shared.persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        if player == nil{
            userIconButton.isHidden = true
            createUserIcon.isHidden = false
            print("No player data")
        }else{
            userIconButton.isHidden = false
            createUserIcon.isHidden = true
        }
        setImages()
        setLayerForButtons(buttons: allButtons)
        view.backgroundColor = .white
        stopButton.isUserInteractionEnabled = false
        gameTimeDisplay.alpha = 0
        timerDisplay.alpha = 0
        gameTitle.backgroundColor = UIColor.customBlue
        stopButton.backgroundColor = UIColor.customBlue
        playButton.backgroundColor = UIColor.customBlue
        userIconButton.backgroundColor = UIColor.customBlue
        bottomView.backgroundColor = UIColor.customBlue
    }
   
    
    //UIElements
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var row0Button0: UIButton!
    @IBOutlet weak var row0Button1: UIButton!
    @IBOutlet weak var row0Button2: UIButton!
    @IBOutlet weak var row0Button3: UIButton!
    @IBOutlet weak var row0Button4: UIButton!
    
    @IBOutlet weak var row1Button0: UIButton!
    @IBOutlet weak var row1Button1: UIButton!
    @IBOutlet weak var row1Button2: UIButton!
    @IBOutlet weak var row1Button3: UIButton!
    @IBOutlet weak var row1Button4: UIButton!
    
    @IBOutlet weak var row2Button0: UIButton!
    @IBOutlet weak var row2Button1: UIButton!
    @IBOutlet weak var row2Button2: UIButton!
    @IBOutlet weak var row2Button3: UIButton!
    @IBOutlet weak var row2Button4: UIButton!
    
    @IBOutlet weak var row3Button0: UIButton!
    @IBOutlet weak var row3Button1: UIButton!
    @IBOutlet weak var row3Button2: UIButton!
    @IBOutlet weak var row3Button3: UIButton!
    @IBOutlet weak var row3Button4: UIButton!
    
    @IBOutlet weak var row4Button0: UIButton!
    @IBOutlet weak var row4Button1: UIButton!
    @IBOutlet weak var row4Button2: UIButton!
    @IBOutlet weak var row4Button3: UIButton!
    @IBOutlet weak var row4Button4: UIButton!
    
    @IBOutlet weak var row5Button0: UIButton!
    @IBOutlet weak var row5Button1: UIButton!
    @IBOutlet weak var row5Button2: UIButton!
    @IBOutlet weak var row5Button3: UIButton!
    @IBOutlet weak var row5Button4: UIButton!
    
    @IBOutlet weak var timerDisplay: UILabel!
    @IBOutlet weak var gameTimeDisplay: UILabel!
    @IBOutlet weak var moveCounter: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var userIconButton: UIButton!
    @IBOutlet weak var createUserIcon: UIButton!
    @IBOutlet weak var gameTitle: UIImageView!
    
    
    func setImages(){
        allButtons.removeAll()
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
        

        switch UIDevice.current.userInterfaceIdiom{
        case .pad:
            allButtons.append(row5Button0)
            allButtons.append(row5Button1)
            allButtons.append(row5Button2)
            allButtons.append(row5Button3)
            allButtons.append(row5Button4)
            
            allButtons.append(row4Button4)
            allButtons.append(row3Button4)
            allButtons.append(row2Button4)
            allButtons.append(row1Button4)
            allButtons.append(row0Button4)
            
            let totalButtons = allButtons.count
            cardImageDataDuplicate = iPadCardData
            let deviceButtons = totalButtons / 2
            
            
            for i in 0..<deviceButtons{
                cardImageDataDuplicate.append(iPadCardData[i])
            }
            cardImageDataDuplicate.shuffle()
        case .phone:
            let totalButtons = allButtons.count
            cardImageDataDuplicate = iPhoneCardData
            let deviceButtons = totalButtons / 2
            print(deviceButtons)
            for i in 0..<deviceButtons{
                cardImageDataDuplicate.append(iPhoneCardData[i])
            }
            cardImageDataDuplicate.shuffle()
        default:
            print("nothing")
        }
        
       
        var counter = 0
        
        for button in allButtons{
            button.setImage(cardImageDataDuplicate[counter].frontImage, for: .normal)
            button.tag = counter
            button.isUserInteractionEnabled = false
            counter += 1
        }
    }
    
    func showImages(){
        var counter = 0
        for button in allButtons{
            button.setImage(cardImageDataDuplicate[counter].backImage, for: .normal)
            button.isUserInteractionEnabled = false
            counter += 1
        }
    }
    func hideImages(){
        var counter = 0
        for button in allButtons{
            button.setImage(cardImageDataDuplicate[counter].frontImage, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
            button.isUserInteractionEnabled = true
            counter += 1
        }
    }
    
    func compareImages(cardOne: UIButton, cardTwo: UIButton){
        if cardOne.currentImage == cardTwo.currentImage{
            matchedCards.append(cardOne)
            matchedCards.append(cardTwo)
            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(removeImages), userInfo: nil, repeats: false)
        } else {
            print("no match")
            cardOne.isUserInteractionEnabled = true
            cardTwo.isUserInteractionEnabled = true
            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(setImagesBack), userInfo: nil, repeats: false)
        }
    }
    
    
    func loadData(){
        let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
        do {
            let loadedPlayer = try context.fetch(fetchRequest)
            self.playerData = loadedPlayer
            for player in playerData{
                self.player = player
            }
        } catch{
            
        }
    }
    
    
    @objc func buttonTapped(sender: UIButton) {
        if buttonCount == 0{
            card1 = sender
            card1?.setImage(cardImageDataDuplicate[sender.tag].backImage, for: .normal)
            card1?.isUserInteractionEnabled = false
            moveCount += 1
            moveCounter.text = "Moves: \(moveCount)"
            buttonCount += 1
        }else if buttonCount > 0 {
            card2 = sender
            card2?.setImage(cardImageDataDuplicate[sender.tag].backImage, for: .normal)
            card2?.isUserInteractionEnabled = false
            for button in allButtons{
                button.isUserInteractionEnabled = false
            }
            compareImages(cardOne: card1!, cardTwo: card2!)
            moveCount += 1
            moveCounter.text = "Moves: \(moveCount)"
            buttonCount = 0
        }
        
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: clickSound)
            soundPlayer.play()
        } catch {
            print("File Error")
        }
    }
    
    @objc func setImagesBack(){
        card1?.setImage(cardImageDataDuplicate[0].frontImage, for: .normal)
        card2?.setImage(cardImageDataDuplicate[0].frontImage, for: .normal)
        for button in allButtons{
            button.isUserInteractionEnabled = true
        }
    }
    
    @objc func removeImages(){
        card1?.alpha = 0
        card2?.alpha = 0
        for button in allButtons{
            button.isUserInteractionEnabled = true
        }
        checkForWin()
    }
    
    @IBAction func playGame(){
        setImages()
        timerDisplay.alpha = 1
        playButton.isUserInteractionEnabled = false
        stopButton.isUserInteractionEnabled = true
        createUserIcon.isUserInteractionEnabled = false
        userIconButton.isUserInteractionEnabled = false
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func stopGame(){
        gameTimer.invalidate()
        let alert = UIAlertController(title: "Game Stopped", message: "The game has been stopped and reset ", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)
        
        present(alert, animated: true) {
            self.resetGame()
            self.playButton.isUserInteractionEnabled = true
        }
    }
    
    
    func checkForWin(){
        if cardImageDataDuplicate.count == matchedCards.count{
            gameTimer.invalidate()
            let timeCompleted = gameTimeDisplay.text
            let movesCompleted = moveCount
            let gamecount = gameCounter
            let winAlert = UIAlertController(title: "Complete!", message: "Good job! You completed the game in \(gameTimeDisplay.text ?? "") and in \(moveCount) moves.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { a in
                print("Time Completed: " + timeCompleted!)
                print("Move Count: " + movesCompleted.description)
                let newPlayerData = Player(context: self.context)
                newPlayerData.dateCompleted = Date()
                newPlayerData.playerName = self.player?.playerName
                newPlayerData.tapsToComplete = Int16(movesCompleted)
                newPlayerData.timeToComplete = Int16(gamecount)
                print(self.gameTimer.timeInterval)
                self.playerData.append(newPlayerData)
                do{
                    try self.context.save()
                }catch{
                    print(error.localizedDescription)
                }
            }
            winAlert.addAction(action)
            present(winAlert, animated: true) {
                self.resetGame()
                self.playButton.isUserInteractionEnabled = true
                self.createUserIcon.isUserInteractionEnabled = true
                self.userIconButton.isUserInteractionEnabled = true
            }
           
        }
    }
    
    func resetGame(){
        moveCount = 0
        gameCounter = 0
        timeCounter = 6
        moveCounter.text = "Moves"
        gameTimeDisplay.text = ""
        matchedCards.removeAll()
        for button in allButtons{
            button.alpha = 1
        }
        setImages()
    }
    
    func startGameTimer(){
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }

   @objc func updateTimer() {
        gameCounter += 1
        gameTimeDisplay.text = timeString(time: TimeInterval(gameCounter))
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    @objc func timerAction(){
        if timeCounter >= 0{
            timeCounter -= 1
            timerDisplay.text = "\(timeCounter)"
            if timeCounter > 0{
                showImages()
            }else if timeCounter == 0{
                hideImages()
                timerDisplay.alpha = 0
                timer?.invalidate()
                timer = nil
                gameTimeDisplay.alpha = 1
                gameCounter += 1
                startGameTimer()
            }
        }
        
    }
    
    
    @IBAction func viewProfile(sender: UIButton){
        performSegue(withIdentifier: "viewProfile", sender: sender)
    }
    
    @IBAction func createPlayer(sender: UIButton){
        performSegue(withIdentifier: "createPlayer", sender: sender)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if player != nil {
            if segue.identifier == "viewProfile"{
                if let userProfile = segue.destination as? PlayerInfoController{
                    
                    userProfile.playerData = playerData
                }
            }
        }else {
            if segue.identifier == "createPlayer"{
                
            }
        }
    }
    
    
    @IBAction func sendNewPlayerData(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source as! CreateProfile
        sourceViewController.createPlayer()
        player = sourceViewController.player
        userIconButton.isHidden = false
        createUserIcon.isHidden = true
        guard let pData = player else {return}
        playerData.append(pData)
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
    
    
}

