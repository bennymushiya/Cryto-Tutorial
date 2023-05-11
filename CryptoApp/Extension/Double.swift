//
//  Double.swift
//  CryptoApp
//
//  Created by Benny Mushiya on 18/01/2023.
//

import Foundation


extension Double {
    
    /// Converts a double into a currency with 2 decimal places
    /// ```
    /// Convert 1234.56 to £1,234.56
    /// ```

    private var currencyFormatter2: NumberFormatter {
        
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current // <- default value
        formatter.currencyCode = "GBP" // <- change currency
        formatter.currencySymbol = "£" // <- change currency value
        formatter.minimumFractionDigits = 2 // <- the amount of decimal places the values are allowed to have.
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
    
    /// Converts a double into a currency as a string with 2 decimal places
    /// ```
    /// Convert 1234.56 to "£1,234.56"
    /// ```
    func asCurrencyWith2Decimals() -> String {
        
        let number = NSNumber(value: self)
        
        return currencyFormatter2.string(from: number) ?? "£0.00"
        
    }
    
    
    
    /// Converts a double into a currency with 2-6 decimal places
    /// ```
    /// Convert 1234.56 to £1,234.56
    /// Convert 12.3456 to £12.3456
    /// Convert 0.1234.56 to £0.234.56
    /// ```

    private var currencyFormatter: NumberFormatter {
        
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current // <- default value
        formatter.currencyCode = "GBP" // <- change currency
        formatter.currencySymbol = "£" // <- change currency value
        formatter.minimumFractionDigits = 2 // <- the amount of decimal places the values are allowed to have.
        formatter.maximumFractionDigits = 6
        
        return formatter
    }
    
    
    /// Converts a double into a currency as a string with 2-6 decimal places
    /// ```
    /// Convert 1234.56 to "£1,234.56"
    /// Convert 12.3456 to "£12.3456"
    /// Convert 0.1234.56 to "£0.234.56"
    /// ```
    func asCurrencyWith6Decimals() -> String {
        
        let number = NSNumber(value: self)
        
        return currencyFormatter.string(from: number) ?? "£0.00"
        
    }
    
    
    
    /// Converts a double into a string representation
    /// ```
    /// Convert 1234.56 to "1.23"
    /// ```
    func asNumberString() -> String {
        
        // takes the current number and formats it to be 2 decimal places
        return String(format: "%.2f", self)
    }
    
    
    /// Converts a double into a string representation with a percent symbol
    /// ```
    /// Convert 1234.56 to "1.23%"
    /// ```
    func asPercentageString() -> String {
        
        return asNumberString() + "%"
    }
}
