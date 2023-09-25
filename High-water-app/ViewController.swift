//
//  ViewController.swift
//  High-water-app
//
//  Created by Anoop on 22/09/23.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, LocationViewModelDelegate, MKMapViewDelegate {

    @IBOutlet weak var topLbl: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var locationViewModel = LocationViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true
        mapView.delegate = self
        locationManager.delegate = self
        locationViewModel.delegate = self
        locationViewModel.getCurrentUserLocation()
        locationViewModel.getDataFromFirebase()
    }
    
    @IBAction func addFloodBtn(_ sender: Any) {
        locationViewModel.saveDataToFirebase()
    }
    
    func responseSavedToFirebase(_ location: [LocationModel]) {
              updateAnnotationss(location)
    }
    
    
    func getUserLocation(_ location: LocationModel) {
        print("Anoop_model:\(location)")
        if location == nil {
            let locations = locationViewModel.model
//            addFloodToMap((locationManager.location?.coordinate.latitude)!, (locationManager.location?.coordinate.longitude)!)
            addFloodToMap(locations)
        } else {
//            addFloodToMap(location.latitude, location.longitude)
            addFloodToMap(location)
        }
    }
    
    func addFloodToMap(_ latitude: LocationModel) {
        let annotation = Annotation(flood: latitude)
        annotation.coordinate.latitude =  annotation.flood.latitude
        annotation.coordinate.longitude =  annotation.flood.longitude
        annotation.title = "Flooded"
        annotation.subtitle = Date().currentDate()
        self.mapView.addAnnotation(annotation)
    }
    
//    func addFloodToMap(_ latitude: Double, _ longitude: Double) {
//        let annotation = MKPointAnnotation()
//        annotation.coordinate.latitude =  latitude
//        annotation.coordinate.longitude =  longitude
//        annotation.title = "Flooded"
//        annotation.subtitle = Date().currentDate()
//        self.mapView.addAnnotation(annotation)
//    }

    private func updateAnnotations() {
        DispatchQueue.main.async {
            self.mapView.removeAnnotations((self.mapView.annotations))
            self.locationViewModel.firebaseResponse.forEach {result in
                print("Anoop")
                self.addFloodToMap(result)
            }
        }
    }
    
    private func updateAnnotationss(_ locationn: [LocationModel]) {
        DispatchQueue.main.async {
            self.mapView.removeAnnotations((self.mapView.annotations))
            locationn.forEach {result in
                self.addFloodToMap(result)
            }
        }
    }
    
    
}

