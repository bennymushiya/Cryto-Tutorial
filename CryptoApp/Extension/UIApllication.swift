//
//  UIApllication.swift
//  CryptoApp
//
//  Created by Benny Mushiya on 21/01/2023.
//

import Foundation
import SwiftUI


extension UIApplication {
    
    // ends the editing on the keyboard to dismiss it whilst using any typing features
    func endEditing() {
        
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    
}
