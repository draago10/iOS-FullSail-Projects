//
//  ArticleDetailView.swift
//  WendelDaniel_FinalSynthesis
//
//  Created by Daniel Wendel on 5/25/21.
//

import UIKit
import WebKit

class ArticleDetailView: UIViewController, WKUIDelegate {

    var artiicle : Article?
    var textColor : UIColor?
    var viewColor : UIColor?
    var sourceName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        articleWebView.isHidden = true
        articleWebView.uiDelegate = self
        articleDescription.isEditable = false
        self.navigationItem.title = sourceName
        if artiicle != nil {
            articleImage.image = artiicle?.urlToImage ?? UIImage(named: "noImg")
            articleTitle.text = artiicle?.title
            articleDescription.text = artiicle?.description
            articleAuthor.text = "Author: \(artiicle?.author ?? "No Data")"
            articlePublishDate.text = "Publish Date: \(artiicle?.publishedDate ?? "No Data")"
            
            articleTitle.textColor = textColor
            articleDescription.textColor = textColor
            articleAuthor.textColor = textColor
            articlePublishDate.textColor = textColor
            view.backgroundColor = viewColor
            articleDescription.backgroundColor = viewColor
            
        }
    }
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleDescription: UITextView!
    @IBOutlet weak var articleAuthor: UILabel!
    @IBOutlet weak var articlePublishDate: UILabel!
    @IBOutlet weak var articleWebView: WKWebView!
    @IBOutlet weak var viewWebsiteButton: UIBarButtonItem!
    
    
    @IBAction func viewWebsiteTapped(_ sender: Any) {
        guard let siteUrl = artiicle?.url else{return}
        if let url = URL(string: siteUrl){
            let request = URLRequest(url: url)
            articleWebView.isHidden = false
            articleWebView.backgroundColor = viewColor
            articleWebView.load(request)
        }
    }
    

    
    func setupUI(){
        articleImage.translatesAutoresizingMaskIntoConstraints = false
        articleImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        articleImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85).isActive = true
        articleImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35).isActive = true
        articleImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        articleTitle.translatesAutoresizingMaskIntoConstraints = false
        articleTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        articleTitle.topAnchor.constraint(equalTo: articleImage.bottomAnchor, constant: 10).isActive = true
        articleTitle.numberOfLines = 0
        articleTitle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90).isActive = true
        
        articleDescription.translatesAutoresizingMaskIntoConstraints = false
        articleDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        articleDescription.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85).isActive = true
        articleDescription.heightAnchor.constraint(equalToConstant: 125).isActive = true
        articleDescription.topAnchor.constraint(equalTo: articleTitle.bottomAnchor, constant: 10).isActive = true
        
        articleAuthor.translatesAutoresizingMaskIntoConstraints = false
        articleAuthor.leftAnchor.constraint(equalTo: articleDescription.leftAnchor).isActive = true
        articleAuthor.topAnchor.constraint(equalTo: articleDescription.bottomAnchor, constant: 10).isActive = true
        
        articlePublishDate.translatesAutoresizingMaskIntoConstraints = false
        articlePublishDate.leftAnchor.constraint(equalTo: articleAuthor.leftAnchor).isActive = true
        articlePublishDate.topAnchor.constraint(equalTo: articleAuthor.bottomAnchor, constant: 10).isActive = true
    }
}
