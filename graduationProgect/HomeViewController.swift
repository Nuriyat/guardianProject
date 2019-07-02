//
//  HomeViewController.swift
//  graduationProgect
//
//  Created by admin on 14/06/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {
    //MARK: - IBOutlets

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var alamofire = ModelHome()
    var massImage: [Home] = []
    var detailsImage = DetailViewController()
    var url: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pars()

    }

    func pars() {
        alamofire.getImageHome(url: URL(string: "http://realstate.diitcenter.ru/api/v1/housing/list")!, success: { (result) in
            for itemsImage in result {
                let imageItem = Home(imageHome: itemsImage["img_preview"] as! String, labelHome: itemsImage["name"] as! String, url: itemsImage["url"] as! String)
                self.massImage.append(imageItem)
            }
            self.collectionView.reloadData()
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
    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return massImage.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestCell", for: indexPath ) as? HomeCVCell else {fatalError("error")}
        cell.mainImage.sd_setImage(with: URL(string: ("\(massImage[indexPath.row].imageHome)")), completed: nil)
        cell.homeLabel.text = massImage[indexPath.row].labelHome
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueInDetails"{
            if let userDetails = segue.destination as? DetailViewController {
                userDetails.url = self.url
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.url = massImage[indexPath.row].url
        performSegue(withIdentifier: "segueInDetails", sender: nil)
    }
    
    
}

