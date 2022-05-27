//
//  ArticlesTableView.swift
//  WendelDaniel_FinalSynthesis
//
//  Created by Daniel Wendel on 5/23/21.
//

import UIKit

class ArticlesTableView: UITableViewController {

    var articleData = [Article]()
    var textColor : UIColor?
    var viewColor : UIColor?
    var sourceName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = viewColor
        self.navigationItem.title = sourceName
        print("Article View: " + articleData.count.description)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleData.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! ArticleCell
        
        
        let articleInformation = articleData[indexPath.row]
        if textColor == UIColor.black{
            cell.title.textColor = .black
        }else{
            cell.title.textColor = textColor
        }
        if viewColor == UIColor.white{
            cell.backgroundColor = .white
        }else{
            cell.backgroundColor = viewColor
        }
        if articleInformation.title != nil{
            cell.title.text = articleInformation.title
        }else{
            cell.title.text = "No Data"
        }
        
        
        if articleInformation.urlToImage != nil{
            cell.articleImage.image = articleInformation.urlToImage
        }else{
            cell.articleImage.image = UIImage(named: "noImg")
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow{
            let articleInfo = articleData[indexPath.row]
            if let destination = segue.destination as? ArticleDetailView{
                destination.artiicle = articleInfo
                destination.sourceName = sourceName
                destination.textColor = textColor
                destination.viewColor = viewColor
            }
        }
    }


}
