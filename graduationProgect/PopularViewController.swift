//
//  PopularViewController.swift
//  graduationProgect
//
//  Created by admin on 14/06/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import SDWebImage

class PopularViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var url: String?
    
    @IBOutlet weak var titlePopularLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var alamofire = ModelHome()
    var itemPopular: [News] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pars()
    }
    
    func pars() {
        
        
        alamofire.getNews(url: URL(string: "http://realstate.diitcenter.ru/api/v1/news/list")!, success: { (result) in
            for itemspopular in result {
                let popularItem = News(imageNew: itemspopular["img_preview"] as! String, titleNew: itemspopular["title"] as! String, description: itemspopular["preview_text"] as! String, url: itemspopular["url"] as! String)

                self.itemPopular.append(popularItem)
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
        return itemPopular.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Popular-Cell", for: indexPath) as! PopularViewCell
        cell.popularImage.sd_setImage(with: URL(string: itemPopular[indexPath.row].imageNew), completed: nil)
        cell.titlePopularLabel.text = itemPopular[indexPath.row].titleNew
        cell.descriptionPopularLabel.text = itemPopular[indexPath.row].description
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.url = itemPopular[indexPath.row].url
        
        performSegue(withIdentifier: "segueInDetailsPopular", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueInDetailsPopular"{
            if let userDetails = segue.destination as? DetailPopularViewController {
                userDetails.url = self.url
            }
        }
    }
    

}

