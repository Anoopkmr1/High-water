//
//  Date+Extension.swift
//  High-water-app
//
//  Created by Anoop on 24/09/23.
//

import Foundation
import UIKit

extension Date {
    func currentDate() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Define your desired date format
        let formattedDate = dateFormatter.string(from: currentDate)
        return formattedDate
    }
}

