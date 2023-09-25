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
    static let shared = LocationService()
    
    init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
    }
    
    private override init() {
        super.init()
    }
    
    func checkLocationPermission() {
        locationManager.delegate = self
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            getUserLocation()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            return
        }
    }

    func getUserLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        if locations.last != nil {
            self.locationManager.stopUpdatingLocation()
            UserPreferences().saveCoordinates("latitude", location.coordinate.latitude)
            UserPreferences().saveCoordinates("longitude", location.coordinate.longitude)
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
