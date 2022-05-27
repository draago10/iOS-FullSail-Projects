//
//  MemberDetailView.swift
//  WendelDaniel_CE05
//
//  Created by Daniel Wendel on 5/13/21.
//

import UIKit

class MemberDetailView: UIViewController {

    var member : CongressPersonal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        if member != nil{
            congressMemberName.text = member?.fullName
            congressMemberImage.image = member?.image
            congressMemberTitle.text = member?.title
            guard let state = member?.stateOfResidence else {return}
            congressMemberState.text = "State: \(state)"
        }
        
        if member?.image == nil{
            congressMemberImage.image = UIImage(named: "noImg")
        }
        
        if member?.party == "R"{
            view.backgroundColor = UIColor(patternImage: UIImage(named: "repBG")!)
            congressMemberParty.text = "Republican"
        } else if member?.party == "D" {
            view.backgroundColor = UIColor(patternImage: UIImage(named: "demBG")!)
            congressMemberParty.text = "Democrat"
            congressMemberParty.textColor = .white
            congressMemberName.textColor = .white
            congressMemberTitle.textColor = .white
            congressMemberState.textColor = .white
            congressMemberState.textColor = .white
            soialMediaLabel.textColor = .white
        } else {
            view.backgroundColor = .white
        }
    }
    
    //UI ELEMENTS
    @IBOutlet weak var congressMemberName: UILabel!
    @IBOutlet weak var congressMemberImage: UIImageView!
    @IBOutlet weak var congressMemberTitle: UILabel!
    @IBOutlet weak var congressMemberState: UILabel!
    @IBOutlet weak var congressMemberParty: UILabel!
    @IBOutlet weak var soialMediaLabel: UILabel!
    @IBOutlet weak var twitterButtonOutlet: UIButton!
    @IBOutlet weak var facebookButtonOutlet: UIButton!
    
    
    
    
    
    //Social Media buttons
    @IBAction func goToSocialMedia(sender: UIButton){
        guard let twitter = member?.twitter else {return}
        guard let fb = member?.facebook else {return}
        guard let twitterUrl = URL(string: "https://twitter.com/\(twitter)") else{return}
        guard let facebookUrl = URL(string: "https://www.facebook.com/\(fb)") else {return}
        switch sender.tag {
        case 0:
            if UIApplication.shared.canOpenURL(twitterUrl){
                UIApplication.shared.open(twitterUrl)
            }
        case 1:
            if UIApplication.shared.canOpenURL(facebookUrl){
                UIApplication.shared.open(facebookUrl)
            }
        default:
            print("error")
        }
    }
    
    func setupUI(){
        congressMemberName.translatesAutoresizingMaskIntoConstraints = false
        congressMemberName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        congressMemberName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        congressMemberImage.translatesAutoresizingMaskIntoConstraints = false
        congressMemberImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        congressMemberImage.topAnchor.constraint(equalTo: congressMemberName.bottomAnchor, constant: 15).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [congressMemberTitle, congressMemberState, congressMemberParty])
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.topAnchor.constraint(equalTo: congressMemberImage.bottomAnchor, constant: 25).isActive = true
        stackView.leftAnchor.constraint(equalTo: congressMemberImage.leftAnchor).isActive = true
        
        soialMediaLabel.translatesAutoresizingMaskIntoConstraints = false
        soialMediaLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 50).isActive = true
        soialMediaLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let buttonStackView = UIStackView(arrangedSubviews: [twitterButtonOutlet, facebookButtonOutlet])
        view.addSubview(buttonStackView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.distribution = .fillEqually
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 30
        buttonStackView.topAnchor.constraint(equalTo: soialMediaLabel.bottomAnchor, constant: 25).isActive = true
        buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        twitterButtonOutlet.translatesAutoresizingMaskIntoConstraints = false
        twitterButtonOutlet.heightAnchor.constraint(equalToConstant: 100).isActive = true
        twitterButtonOutlet.widthAnchor.constraint(equalToConstant: 100).isActive = true
        facebookButtonOutlet.translatesAutoresizingMaskIntoConstraints = false
        facebookButtonOutlet.heightAnchor.constraint(equalToConstant: 100).isActive = true
        facebookButtonOutlet.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
}
