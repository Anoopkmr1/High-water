//
//  LocationViewModel.swift
//  High-water-app
//
//  Created by Anoop on 22/09/23.
//

import Foundation
import CoreLocation

protocol LocationViewModelDelegate {
    func pinUserLocation(_ location: LocationModel)
    func responseSavedToFirebase(_ location: [LocationModel])
}

class LocationViewModel: NSObject {
    
    var firebaseResponse:[LocationModel] = []
    var delegate: LocationViewModelDelegate?
    var model =  LocationModel(latitude: UserPreferences().getCoordinates("latitude"), longitude: UserPreferences().getCoordinates("longitude"), docId: "" )
    
    func getCurrentUserLocation() {
        LocationService.shared.checkLocationPermission()
    }
    
    func saveDataToFirebase() {
        FirebaseService.shared.saveFloodToFirebase(model) { id in
            self.model.docId = id
        }
        delegate?.pinUserLocation(model)
    }
    
    func getDataFromFirebase() {
        FirebaseService.shared.getFloodFromFirebase { response in
            if let locations = response {
                self.firebaseResponse = locations
            }
            self.delegate?.responseSavedToFirebase(self.firebaseResponse)
        }
    }

}
