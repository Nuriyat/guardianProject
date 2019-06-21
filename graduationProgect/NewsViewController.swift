//
//  NewsViewController.swift
//  graduationProgect
//
//  Created by admin on 14/06/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit


class NewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

 
    @IBOutlet weak var titleNewsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var alamofire = ModelHome()
    var itemNew: [News] = []
    var url: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        pars()
    }

    func pars() {
        alamofire.getNews(url: URL(string: "http://realstate.diitcenter.ru/api/v1/news/list")!, success: { (result) in
            for itemsNews in result {
                let newsItem = News(imageNew: itemsNews["img_preview"] as! String, titleNew: itemsNews["title"] as! String, description: itemsNews["preview_text"] as! String, url: itemsNews["url"] as! String)
                
                self.itemNew.append(newsItem)
            }
            self.tableView.reloadData()
        }) { (failure) in
            switch failure {
            case "noResult": self.showAlert(title: "error", message: "noResult")
            case "noResponse": self.showAlert(title: "error", message: "noResponse")
            default:
                self.showAlert(title: "error", message: "default")
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        present(alert, animated: true)
    }


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemNew.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "News-Cell", for: indexPath) as! NewsViewCell
        cell.newsImage.sd_setImage(with: URL(string: "\(itemNew[indexPath.row].imageNew)"), completed: nil)
        cell.titleNewsLabel.text = itemNew[indexPath.row].titleNew
        cell.descripthionNewsLabel.text = itemNew[indexPath.row].description
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.url = itemNew[indexPath.row].url

        performSegue(withIdentifier: "segueInDetailsNews", sender: nil)

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueInDetailsNews"{
            if let userDetails = segue.destination as? DetailNewsViewController {
                userDetails.url = self.url
            }
        }
    }
    

}
