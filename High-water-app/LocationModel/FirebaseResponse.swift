//
//  FirebaseResponse.swift
//  High-water-app
//
//  Created by Anoop on 24/09/23.
//

import Foundation
import UIKit

struct FirebaseResponse {
    var result: Bool
    var message: String
    
    init(result: Bool, message: String) {
        self.result = result
        self.message = message
    }
}
