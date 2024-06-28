//
//  Extensions.swift
//  ClipherVault517
//
//  Created by Александр Печинкин on 25.06.2024.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


extension UserDefaults {
    func getAssets(forKey key: String)  -> [Asset] {
        if let data = data(forKey: key), let asset = try? JSONDecoder().decode([Asset].self, from: data) {
            return asset
        }
        return []
    }
    
    func setAssets(_ asset: [Asset], forKey key: String) {
        if let encoded = try? JSONEncoder().encode(asset) {
            set(encoded, forKey: key)
        }
    }
    
    func getCurrencys(forKey key: String)  -> [Currency] {
        if let data = data(forKey: key), let currency = try? JSONDecoder().decode([Currency].self, from: data) {
            return currency
        }
        return []
    }
    
    func setCurrencys(_ currency: [Currency], forKey key: String) {
        if let encoded = try? JSONEncoder().encode(currency) {
            set(encoded, forKey: key)
        }
    }
    
    func getCalculations(forKey key: String)  -> [Calculation] {
        if let data = data(forKey: key), let calculation = try? JSONDecoder().decode([Calculation].self, from: data) {
            return calculation
        }
        return []
    }
    
    func setCalculations(_ calculation: [Calculation], forKey key: String) {
        if let encoded = try? JSONEncoder().encode(calculation) {
            set(encoded, forKey: key)
        }
    }
}

