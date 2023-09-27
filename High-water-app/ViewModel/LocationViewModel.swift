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
    
    
    func getCurrentUserLocation() {
        LocationService.shared.checkLocationPermission()
    }
    
    func saveDataToFirebase() {
        var model =  LocationModel(latitude: UserPreferences().getCoordinates("latitude"), longitude: UserPreferences().getCoordinates("longitude"), docId: "" )
        FirebaseService.shared.saveFloodToFirebase(model) { id in
            model.docId = id
            self.delegate?.pinUserLocation(model)
        }
       
    }
    
    func getDataFromFirebase() {
        FirebaseService.shared.getFloodFromFirebase { response in
            if let locations = response {
                self.firebaseResponse = locations
            }
            self.delegate?.responseSavedToFirebase(self.firebaseResponse)
        }
    }
    
    func deletePin(_ id: String, completion:@escaping(_ result: String) -> Void) {
        FirebaseService.shared.removePinFromFirebase(id) { response in
            if response == "sucess" {
                completion(response)
            }
        }
    }

}
