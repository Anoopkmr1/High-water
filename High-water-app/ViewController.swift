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
        locationViewModel.delegate = self
        mapView.delegate = self
        locationViewModel.getCurrentUserLocation()
        locationViewModel.getDataFromFirebase()
    }
    
    @IBAction func addFloodBtn(_ sender: Any) {
        locationViewModel.saveDataToFirebase()
    }
    
    func responseSavedToFirebase(_ location: [LocationModel]) {
        updateAnnotationsFromMap(location)
    }
    
    func pinUserLocation(_ location: LocationModel) {
        addFloodToMap(location)
    }
    
    func addFloodToMap(_ location: LocationModel) {
        let annotation = MKPointAnnotation()
        annotation.coordinate.latitude =  location.latitude
        annotation.coordinate.longitude =  location.longitude
        annotation.title = "Flooded"
        annotation.subtitle = location.docId
        self.mapView.addAnnotation(annotation)
    }

    private func updateAnnotationsFromMap(_ locationn: [LocationModel]) {
        DispatchQueue.main.async {
            self.mapView.removeAnnotations((self.mapView.annotations))
            locationn.forEach {result in
                self.addFloodToMap(result)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let id = view.annotation?.subtitle else {
            return
        }
        mapView.removeAnnotation(view.annotation!)
        locationViewModel.deletePin(id!) { result in
            if result == "success" {
                print("Deleted")
            }
        }
    }
 
}

