//
//  ContentView.swift
//  CryptoApp
//
//  Created by Benny Mushiya on 18/01/2023.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
       
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack {
                
                Text("accent color")
                    .foregroundColor(Color.theme.accent)
                
                Text("secondary text color")
                    .foregroundColor(Color.theme.red)
                
                
                Text("red color")
                    .foregroundColor(Color.theme.green)
                
                
                Text("green clor")
                    .foregroundColor(Color.theme.secondaryText)
            }
            
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
