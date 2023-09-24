//
//  LocationViewModel.swift
//  High-water-app
//
//  Created by Anoop on 22/09/23.
//

import Foundation
import CoreLocation

protocol LocationViewModelDelegate {
    func getUserLocation(_ location: LocationModel)
}
protocol FirebaseResponseDelegate {
    func responseSavedToFirebase()
}


class LocationViewModel: NSObject {
    
    
    var delegate: LocationViewModelDelegate?
    var delegate2: FirebaseResponseDelegate?
    let model =  LocationModel(latitude: UserPreferences().getCoordinates("latitude"), longitude: UserPreferences().getCoordinates("longitude"))
    
    func getCurrentUserLocation() {
      
        LocationService.shared.getUserLocation()   
    }
    
    func saveDataToFirebase() {
//        delegate2?.responseSavedToFirebase()
        FirebaseService.shared.saveFloodToFirebase(model)
        delegate?.getUserLocation(model)
    }
    
    
}
