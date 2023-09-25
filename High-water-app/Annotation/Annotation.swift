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

//class CustomAnnotation: MKPointAnnotation {
//    var customImage: UIImage?
//
//    init(title: String?, subtitle: String?, image: UIImage?) {
//        super.init()
//        self.title = title
//        self.subtitle = subtitle
//        self.customImage = image
//    }
//}
