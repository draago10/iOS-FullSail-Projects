//
//  ViewController.swift
//  WendelDaniel_RPS_MCProject
//
//  Created by Daniel Wendel on 6/16/21.
//

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController, MCBrowserViewControllerDelegate, MCSessionDelegate, MCNearbyServiceAdvertiserDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMultipeerConnectivity()
        disconnectedUI()
        self.navigationItem.title = userName
        playButtonOutlet.layer.cornerRadius = 20
        
    }
    
    //NEEDED VARIABLES TO CREATE MULTIPEER CONNECTIVITY
    var peerID: MCPeerID!
    var session: MCSession!
    var browser: MCBrowserViewController!
    var advertiser: MCNearbyServiceAdvertiser!
    var serviceId = "rpsChannel"
    
    var userName = ""
    var opponentName = ""
    
    //NEEDED VARIABLES TO PLAY RPS
    //Score Containers
    var playerWins = 0
    var opponentWins = 0
    var draw = 0
    
    //Players choice of R/P/S
    var playerChoice = "didNotChoose"
    var opponentChoice = "didNotChoose"
    
    //Check to see if the players are ready to play
    var playerReadyToPlay = "false"
    var opponentReadyToPlay = "false"
    
    //Timer that starts game when hits 0
    var gameTimer : Timer?
    var gameTimerCount = 4
    
    
    //UI ELEMENT OUTLETS
    @IBOutlet weak var topViewContainer: UIView!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var opponentWinsLabel: UILabel!
    @IBOutlet weak var drawsLabel: UILabel!
    @IBOutlet weak var multipurposeLabel: UILabel!
    @IBOutlet weak var buttonContainer: UIView!
    @IBOutlet weak var playButtonOutlet: UIButton!
    @IBOutlet weak var disconnectButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var connectButtonoOutlet: UIBarButtonItem!
    @IBOutlet weak var rockButton: UIButton!
    @IBOutlet weak var paperButton: UIButton!
    @IBOutlet weak var scissorButton: UIButton!
    
    
    
    
    //CONNECT/DISCONNECT BUTTONS
    @IBAction func connectToPlayer(_ sender: Any) {
        browser = MCBrowserViewController(serviceType: serviceId, session: session)
        browser.delegate = self
        present(browser, animated: true, completion: nil)
    }
    
    @IBAction func disconnectFromPlayer(_ sender: Any) {
        session.disconnect()
        self.advertiser.startAdvertisingPeer()
    }
    
    //CONNECTED/DISCONNECTED UI
    func connectedUI(){
        rockButton.isUserInteractionEnabled = false
        paperButton.isUserInteractionEnabled = false
        scissorButton.isUserInteractionEnabled = false
        topViewContainer.isHidden = false
        buttonContainer.isHidden = false
        playButtonOutlet.isHidden = false
        disconnectButtonOutlet.isEnabled = true
        connectButtonoOutlet.isEnabled = false
        multipurposeLabel.text = "Ready to play?"
        self.winsLabel.text = userName
        self.opponentWinsLabel.text = opponentName
    }
    
    func disconnectedUI(){
        topViewContainer.isHidden = true
        multipurposeLabel.text = "Not connected to anyone. Click the connecto button to play."
        buttonContainer.isHidden = true
        playButtonOutlet.isHidden = true
        disconnectButtonOutlet.isEnabled = false
        connectButtonoOutlet.isEnabled = true
        self.winsLabel.text = ""
        self.opponentWinsLabel.text = ""
        self.navigationItem.title = userName
    }
    

    
    
    
    @IBAction func assignGameChoice(sender: UIButton){
        switch sender.tag{
        case 0:
            playerChoice = "rock"
            paperButton.alpha = 0
            scissorButton.alpha = 0
        case 1:
            playerChoice = "paper"
            rockButton.alpha = 0
            scissorButton.alpha = 0
        case 2:
            playerChoice = "scissors"
            rockButton.alpha = 0
            paperButton.alpha = 0
        default:
            print("RPS Choice default hit")
        }
    }
    
    func checkWinner(){
        switch opponentChoice{
        case "rock":
            if playerChoice == "rock"{
                print("tie")
                draw += 1
                drawsLabel.text = "Draw: \(draw)"
                multipurposeLabel.text = "DRAW!"
                
            } else if playerChoice == "paper"{
                multipurposeLabel.text = "WINNER! Opponent choose \(opponentChoice)"
                playerWins += 1
                winsLabel.text = "\(userName) Wins: \(playerWins)"
                opponentWinsLabel.text = "\(opponentName) Wins: \(opponentWins)"
                
            } else if playerChoice == "scissors" {
                multipurposeLabel.text = "LOSER! Opponent choose \(opponentChoice)"
                opponentWins += 1
                opponentWinsLabel.text = "\(opponentName) Wins: \(opponentWins)"
                winsLabel.text = "\(userName) Wins: \(playerWins)"
                
            } else if playerChoice == "didNotChoose"{
                multipurposeLabel.text = "You did not choose."
                opponentWins += 1
                opponentWinsLabel.text = "\(opponentName) Wins: \(opponentWins)"
                winsLabel.text = "\(userName) Wins: \(playerWins)"
            }
        case "paper":
            if playerChoice == "rock"{
                opponentWins += 1
                opponentWinsLabel.text = "\(opponentName) Wins: \(opponentWins)"
                winsLabel.text = "\(userName) Wins: \(playerWins)"
                multipurposeLabel.text = "LOSER! Opponent choose \(opponentChoice)"
                print("player loses")
            } else if playerChoice == "paper"{
                print("tie")
                draw += 1
                drawsLabel.text = "Draws: \(draw)"
                multipurposeLabel.text = "DRAW!"
            } else if playerChoice == "scissors" {
                print("player wins")
                playerWins += 1
                winsLabel.text = "\(userName) Wins: \(playerWins)"
                opponentWinsLabel.text = "\(opponentName) Wins: \(opponentWins)"
                multipurposeLabel.text = "WINNER! Opponent choose \(opponentChoice)"
            
            } else if playerChoice == "didNotChoose"{
                multipurposeLabel.text = "You did not choose."
                opponentWins += 1
                opponentWinsLabel.text = "\(opponentName) Wins: \(opponentWins)"
                winsLabel.text = "\(userName) Wins: \(playerWins)"
            }
        case "scissors":
            if playerChoice == "rock"{
                print("player wins")
                playerWins += 1
                winsLabel.text = "\(userName) Wins: \(playerWins)"
                opponentWinsLabel.text = "\(opponentName) Wins: \(opponentWins)"
                multipurposeLabel.text = "WINNER! Opponent choose \(opponentChoice)"
            } else if playerChoice == "paper"{
                print("player loses")
                opponentWins += 1
                opponentWinsLabel.text = "\(opponentName) Wins: \(opponentWins)"
                winsLabel.text = "\(userName) Wins: \(playerWins)"
                multipurposeLabel.text = "LOSER! Opponent choose \(opponentChoice)"
            } else if playerChoice == "scissors" {
                print("tie")
                draw += 1
                drawsLabel.text = "Draws: \(draw)"
                multipurposeLabel.text = "DRAW!"
            } else if playerChoice == "didNotChoose"{
                multipurposeLabel.text = "You did not choose."
                opponentWins += 1
                opponentWinsLabel.text = "\(opponentName) Wins: \(opponentWins)"
                winsLabel.text = "\(userName) Wins: \(playerWins)"
            }
            
        default:
            multipurposeLabel.text = "No one made a choice."
            print("Default hit")
        }
        
        playerReadyToPlay = "false"
        opponentReadyToPlay = "false"
        playerChoice = "didNotChoose"
        opponentChoice = "didNotChoose"
        
    }
    
    @objc func countDownTimer(){
        print(gameTimerCount)
        if gameTimerCount > 0{
            
            gameTimerCount -= 1
            multipurposeLabel.text = "\(gameTimerCount)"
            playButtonOutlet.isEnabled = false
            rockButton.isUserInteractionEnabled = true
            paperButton.isUserInteractionEnabled = true
            scissorButton.isUserInteractionEnabled = true
            
        } else{
            if let data = playerChoice.data(using: String.Encoding.utf8){
                do {
                    try session.send(data, toPeers: session.connectedPeers, with: .reliable)
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            gameTimer?.invalidate()
            gameTimerCount = 4
            playButtonOutlet.isEnabled = true
            rockButton.alpha = 1
            paperButton.alpha = 1
            scissorButton.alpha = 1
            rockButton.isUserInteractionEnabled = false
            paperButton.isUserInteractionEnabled = false
            scissorButton.isUserInteractionEnabled = false
        }
    }
    
    func getReadyToStartGame(){
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDownTimer), userInfo: nil, repeats: true)

    }
    
   @IBAction func startGame(sender: UIButton){
        playerReadyToPlay = "true"
        if let data = playerReadyToPlay.data(using: String.Encoding.utf8){
            do {
                try session.send(data, toPeers: session.connectedPeers, with: .reliable)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        if playerReadyToPlay == "true" && opponentReadyToPlay == "true"{
            getReadyToStartGame()
        }
    }
    
    
    //FUNC TO SET UP MULTIPEER CONNECTIVITY
    func setupMultipeerConnectivity(){
        peerID = MCPeerID(displayName: userName)
        session = MCSession(peer: peerID)
        session.delegate = self
        
        advertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: serviceId)
        advertiser.startAdvertisingPeer()
        advertiser.delegate = self
    }
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        browserViewController.dismiss(animated: true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        browserViewController.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: MULTIPEER CONNECTIVITY DELEGATE METHODS
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state{
        case .connected:
            if session.connectedPeers.count > 0{
                advertiser.stopAdvertisingPeer()
                DispatchQueue.main.async {
                    self.connectedUI()
                    
                }
                self.opponentName = peerID.displayName
            }
        case .connecting:
            print("Connecting")
        case .notConnected:
            DispatchQueue.main.async {
                self.disconnectedUI()
                let alert = UIAlertController(title: "Disconnected", message: "You have been disconnected from \(peerID.displayName)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        default:
            print("Default hit")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        //find out if the other player is ready to play
        if let data = String(data: data, encoding: String.Encoding.utf8){
            if data == "true"{
                DispatchQueue.main.async {
                    
                    self.navigationItem.title = "\(self.session.connectedPeers[0].displayName) is ready!"
                    self.opponentReadyToPlay = "true"
                    
                    if self.playerReadyToPlay == "true" && self.opponentReadyToPlay == "true"{
                        self.getReadyToStartGame()
                        
                        print("BOTH PLAYERS ARE READY")
                    }
                }
            } else {
                switch data{
                case "rock":
                    self.opponentChoice = "rock"
                    
                    DispatchQueue.main.async {
                        self.checkWinner()
                    }
                case "paper":
                    self.opponentChoice = "paper"
                    DispatchQueue.main.async {
                        self.checkWinner()
                    }
                case "scissors":
                    self.opponentChoice = "scissors"
                    DispatchQueue.main.async {
                        self.checkWinner()
                    }
                default:
                    DispatchQueue.main.async {
                        self.checkWinner()
                    }
                    print("Default hit")
                }
                DispatchQueue.main.async {
                    self.navigationItem.title = "Play again?"
                    self.opponentReadyToPlay = "false"
                }
            }
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        //alert user to connect
        let alert = UIAlertController(title: "Incoming connection from \(peerID.displayName)", message: "Do you want to connect?", preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "Accept", style: .default) { action in
            invitationHandler(true, self.session)
        }
        let declineAction = UIAlertAction(title: "Decline", style: .destructive) { action in
            invitationHandler(false, self.session)
        }
        
        alert.addAction(acceptAction)
        alert.addAction(declineAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}

