//
//  LoadViewController.swift
//  WendelDaniel_FinalSynthesis
//
//  Created by Daniel Wendel on 5/23/21.
//

import UIKit

class LoadViewController: UIViewController {
    
    var articleData = [[Source]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pullFromApi(url: "https://newsapi.org/v1/sources?apiKey=a0f095648a204e7aa900f16bfdf9c7ea")
        activityIndicator.style = .medium
        activityIndicator.color = .black
        
        
        loadingSourcesLabel.translatesAutoresizingMaskIntoConstraints = false
        loadingSourcesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        loadingSourcesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingSourcesLabel: UILabel!
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSourceView"{
            if let destination = segue.destination as? UINavigationController{
                if let sourceVC = destination.topViewController as? ViewController{
                    sourceVC.articleData = articleData
                }
                
            }
        }
    }

    
    
}
