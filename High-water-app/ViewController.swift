//
//  ViewController.swift
//  High-water-app
//
//  Created by Anoop on 22/09/23.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, LocationViewModelDelegate {

    @IBOutlet weak var topLbl: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var locationViewModel = LocationViewModel()
    var model: LocationModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true
        locationManager.delegate = self
        locationViewModel.delegate = self
        locationViewModel.getCurrentUserLocation()
    }
    
    @IBAction func addFloodBtn(_ sender: Any) {
        locationViewModel.saveDataToFirebase()
    }
    
    
    func getUserLocation(_ location: LocationModel) {
        if location == nil {
            addFloodToMap((locationManager.location?.coordinate.latitude)!, (locationManager.location?.coordinate.longitude)!)
        } else {
            addFloodToMap(location.latitude, location.longitude)
        }
    }
    
    
    func addFloodToMap(_ latitude: Double, _ longitude: Double) {
        let annotation = MKPointAnnotation()
        annotation.coordinate.latitude =  latitude
        annotation.coordinate.longitude =  longitude
        annotation.title = "Flooded"
        annotation.subtitle = currentDate()
        self.mapView.addAnnotation(annotation)
    }
    
    func currentDate() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Define your desired date format
        let formattedDate = dateFormatter.string(from: currentDate)
        return formattedDate
    }
    
    
    
    

}

