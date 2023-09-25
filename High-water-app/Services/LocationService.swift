//
//  LocationService.swift
//  High-water-app
//
//  Created by Anoop on 22/09/23.
//

import Foundation
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
    }
    
    func getUserLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       guard let location = locations.last else { return }
       if locations.last != nil {
           self.locationManager.stopUpdatingLocation()
          let pref = UserPreferences()
           pref.saveCoordinates("latitude", location.coordinate.latitude)
           pref.saveCoordinates("longitude", location.coordinate.longitude)
       }
   }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
}
