//
//  DetailNewsViewController.swift
//  graduationProgect
//
//  Created by admin on 19/06/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import SDWebImage

struct DetailsNews {
    
}

class DetailNewsViewController: UIViewController {

    @IBOutlet weak var detailINewsImage: UIImageView!

    @IBOutlet weak var detailNewsLabel: UILabel!
    @IBOutlet weak var detailDescriptionNewsLabel: UILabel!
    var url: String?

    
    var alamofire = ModelHome()
    var itemNewsDetails: [DetailsNews] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pars()
    }
    
    
    func pars() {
        guard let url = self.url else { return }

        alamofire.getNewsDetails(url: URL(string: url)!, success: { (result) in
            let rest = result
            self.detailINewsImage.sd_setImage(with: URL(string: rest["img_preview"] as! String), completed: nil)
            self.detailNewsLabel.text = rest["title"] as? String
            self.detailDescriptionNewsLabel.text = rest["detail_text"] as? String
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

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
