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
    func responseSavedToFirebase(_ location: [LocationModel])
}


class LocationViewModel: NSObject {
    
    var firebaseResponse:[LocationModel] = []
//    var firebaseId: FirebaseModel?
    var delegate: LocationViewModelDelegate?
    var model =  LocationModel(latitude: UserPreferences().getCoordinates("latitude"), longitude: UserPreferences().getCoordinates("longitude"), docId: "" )
    
    func getCurrentUserLocation() {
        LocationService.shared.getUserLocation()   
    }
    
    func saveDataToFirebase() {
//        delegate2?.responseSavedToFirebase()
//        FirebaseService.shared.saveFloodToFirebase(model, completion: <#(String) -> Void#>)
        FirebaseService.shared.saveFloodToFirebase(model) { id in
            self.model.docId = id
        }
        delegate?.getUserLocation(model)
    }
    
    func getDataFromFirebase() {
        FirebaseService.shared.getFloodFromFirebase { response in
             if let locations = response {
                 self.firebaseResponse = locations
                 print("Retrieved locations: \(self.firebaseResponse)")
                }
            self.delegate?.responseSavedToFirebase(self.firebaseResponse)
            }
       
    }
    
    
    
    
}
