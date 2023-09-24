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
    
    
    func saveFloodToFirebase(_ dataMap: LocationModel) {
        self.documentRef = self.db.collection("High-water").addDocument(data: dataMap.toDictionary()) { [self] error in
            if let error = error {
                print(error)
            } else {
               print("Data added")
//                flood.documentID = self?.documentRef?.documentID
//                self?.addFloodToMap(flood)
            }
        }
    }
    
}
