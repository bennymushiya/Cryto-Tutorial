//
//  Color.swift
//  CryptoApp
//
//  Created by Benny Mushiya on 18/01/2023.
//

import SwiftUI
import Foundation


// any time we call color we can access the theme and the theme has access to various different colors. the static makes it a single instance that gets reused over and over
extension Color {
    
    static let theme = ColorTheme()
    
    
}


// and this color them can be used on the entire app, also it automaticly adapts to dark mode becasue we did that in our assets folder
struct ColorTheme {
   
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
   
}

