//
//  LocationModel.swift
//  High-water-app
//
//  Created by Anoop on 24/09/23.
//

import Foundation
import FirebaseFirestore
import FirebaseCore

struct LocationModel {
    var latitude: Double
    var longitude: Double
    var docId: String?
    
    init(latitude: Double, longitude: Double, docId: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.docId = docId
    } 
}

extension LocationModel {
    init?(_ snapshot: QueryDocumentSnapshot) {
        guard let latitude = snapshot["latitude"] as? Double,
            let longitude = snapshot["longitude"] as? Double else {
                return nil
        }

        self.latitude = latitude
        self.longitude = longitude
        self.docId = snapshot.documentID
    }
}
