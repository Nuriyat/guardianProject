//
//  DetailViewController.swift
//  graduationProgect
//
//  Created by admin on 15/06/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import MapKit
import SDWebImage

struct ImageDetails {
    var image: String
    var descriptionLabel: String
    var priceLabel: String
    var locationLabel: String
    var headerLabel: String
    
    
}

class DetailViewController: UIViewController {

    
    @IBOutlet weak var headerLabel: UILabel!
    
    var url: String?
    
    var alamofire = ModelHome()


    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var toBookLabel: UILabel!
    @IBOutlet weak var locationIconLabel: UIImageView!
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    
    var imageArray: [String] = []
    

    var timer = Timer()
    var counter = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let location = CLLocationCoordinate2D(latitude: 42.97419251244096 , longitude: 47.48394685098902)
        let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
        mapView.setRegion(region, animated: true)
        
        
        checkLocationServices()
        pars()

    }
    
    
    func pars() {
        
        guard let url = self.url else { return }
        
        alamofire.getImageHomeDetails(url: URL(string: url)!, success: { (result) in
            
            self.headerLabel.text = result["name"] as! String
            self.locationLabel.text = result["location"] as! String
            self.priceLabel.text = "Цена: \(result["price"]!) рублей!" as! String
            self.descriptionLabel.text = result["description"] as! String
            
            let arrayImageItem: [[String: String]] = result["images"] as! [[String : String]]
            
            for itemsImage in arrayImageItem {
                self.imageArray.append(itemsImage["img"]!)
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
    
    @IBAction func toBookButton(_ sender: Any) {
        performSegue(withIdentifier: "ToBook", sender: nil)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        present(alert, animated: true)
    }

    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
//            setupLocationManader()
            checkLocationAutorization()
        } else{
//            Show an alert letting the user know they have to turn this on
        }
    }
    
    func checkLocationAutorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.stopUpdatingLocation()
            break
        case .denied:
//            Show an alert instructing them how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
//            Show an alert letting them know what's up
            break
        case .authorizedAlways:
            break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        
    }

}
//MARK: UICollectionView

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? InterestCollectionViewCell else {fatalError("Errrrrrrooooorrrr")}
        cell.mainImage.sd_setImage(with: URL(string: imageArray[indexPath.row])) { (image, error, cache, url) in
            print(image)
        }
        return cell

    }

}
//MARK: UICollectionView

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
//MARK: MKMapVIew

extension DetailViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: CLLocation) {
        
        let center = CLLocationCoordinate2D(latitude: locations.coordinate.latitude, longitude: locations.coordinate.latitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAutorization()
}

    
}
