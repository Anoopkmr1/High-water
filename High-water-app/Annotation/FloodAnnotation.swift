//
//  FloodAnnotation.swift
//  High-water-app
//
//  Created by Anoop on 25/09/23.
//

import Foundation
import MapKit
import UIKit

class FloodAnnotation: MKPointAnnotation {
    
    let flood: LocationModel
    
    init(flood: LocationModel) {
        self.flood = flood
    }
    
}
