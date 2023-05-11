//
//  CircleButtonView.swift
//  CryptoApp
//
//  Created by Benny Mushiya on 18/01/2023.
//

import SwiftUI

struct CircleButtonView: View {
    
    //MARK: - PROPERTIES
    
    // everytime this view get used it will ask for an icon name before its initialised
    let iconName: String
    
    
    //MARK: - BODY
    
    var body: some View {
        
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(Color.theme.accent)
        
        // we dont need the alignment becasue its center by default
            .frame(width: 50, height: 50)
        
        // background controls the background of the image like the circle here
            .background(
            
                Circle()
                    .foregroundColor(Color.theme.background)
            )
            .shadow(color: Color.theme.accent.opacity(0.25), radius: 10, x: 0, y: 0)
            .padding()
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonView(iconName: "plus")
    }
}
