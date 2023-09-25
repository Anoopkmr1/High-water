//
//  Structure+Extension.swift
//  High-water-app
//
//  Created by Anoop on 24/09/23.
//

import Foundation
import UIKit

extension LocationModel {
    func toDictionary() -> [String:Any] {
        return [
            "latitude": self.latitude,
            "longitude": self.longitude,
        ]
    }
}
