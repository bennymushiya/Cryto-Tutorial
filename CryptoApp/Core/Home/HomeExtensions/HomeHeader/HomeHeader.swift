//
//  HomeHeader.swift
//  CryptoApp
//
//  Created by Benny Mushiya on 18/01/2023.
//

import SwiftUI

struct HomeHeader: View {
    
    //MARK: - PROPERTIES
    
    // by making it private we are telling the code this property will only be accessed only within this view. and state updates the UI accordingly when the property changes
    @Binding var showPortfolio: Bool
    
    //MARK: - BODY 
    
    var body: some View {
        
        HStack {
            
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .background(
                
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            
            Spacer()
            
            Text(showPortfolio ? "Live Prices" : "Portfolio")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)

            Spacer()
            CircleButtonView(iconName: "chevron.right")
            
            // if showPortfolio equals true we change it to 180 else to 0
                .rotationEffect(Angle(degrees: showPortfolio ? 0 :  180))
            
            //
                .onTapGesture {
                    
                    withAnimation(.spring()) {
                        
                        // we toggle the boolean property to true or false
                        showPortfolio.toggle()
                    }
                }

        }
        .padding(.horizontal)
    }
}

struct HomeHeader_Previews: PreviewProvider {
    static var previews: some View {
        
        HomeHeader(showPortfolio: .constant(false))
    }
}
