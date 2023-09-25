//
//  Annotation.swift
//  High-water-app
//
//  Created by Anoop on 24/09/23.
//

import Foundation
import MapKit

class Annotation: MKPointAnnotation {

    let flood: LocationModel
    init(flood: LocationModel) {
        self.flood = flood
    }
}
