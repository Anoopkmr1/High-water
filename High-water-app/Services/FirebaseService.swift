//
//  FirebaseService.swift
//  High-water-app
//
//  Created by Anoop on 24/09/23.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseFirestore



class FirebaseService: NSObject {
    static let shared = FirebaseService()
    private override init() {
        super.init()
    }
    
    private let db = Firestore.firestore()
    var documentRef: DocumentReference? = nil
    var locations: [LocationModel] = []
    
    
    func saveFloodToFirebase(_ dataMap: LocationModel, completion:@escaping(_ id: String) -> Void) {
        var flood = LocationModel(latitude: dataMap.latitude, longitude: dataMap.longitude, docId: "")
        self.documentRef = self.db.collection("High-water").addDocument(data: dataMap.toDictionary()) { [self] error in
            if let error = error {
                print(error)
            } else {
                print("Data added")
                completion(documentRef!.documentID)
            }
        }
    }
    
    func getFloodFromFirebase(completin: @escaping([LocationModel]?) -> Void) {
        db.collection("High-water").getDocuments { [self] snapshot, error in
            guard let documents = snapshot?.documents else {
                print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // Map the Firestore documents to Location objects
            self.locations = documents.compactMap { document in
                let docId = document.documentID
                let data = document.data()
                if let latitude = data["latitude"] as? Double, let longitude = data["longitude"] as? Double {
                    return LocationModel(latitude: latitude, longitude: longitude, docId: docId)
                } else {
                    return nil
                }
            }
            completin(locations)
        }
    }
    
    
    func  removePinFromFirebase(_ id: String, completion:@escaping(_ result: String) -> Void) {
        db.collection("High-water").document(id).delete() { error in
            if let error = error {
                print("Error:\(error.localizedDescription)")
            } else {
                print("success")
                completion("success")
            }
        }
    }
    
    
}
