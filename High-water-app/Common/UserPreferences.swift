//
//  UserPreferences.swift
//  High-water-app
//
//  Created by Anoop on 24/09/23.
//

import Foundation


struct UserPreferences {
    
    func saveCoordinates(_ key: String, _ value: Double) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func getCoordinates(_ key: String) -> Double {
        return UserDefaults.standard.value(forKey: key) as? Double ?? 0
    }
    
}
