//
//  ExtensionInt.swift
//  testNoStory
//
//  Created by Andres Valerio on 14/02/23.
//

import Foundation

extension Int{
    
    func getDuration() -> String {
        let seconds = self * 60
        let timeInterval = TimeInterval(seconds)
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        guard let duration = formatter.string(from: timeInterval) else { return "0" }
        return duration
    }
    
    func getCurrencyFormat() -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        return currencyFormatter.string(from: NSNumber(value: self)) ?? " $0.00"
    }
    
}
