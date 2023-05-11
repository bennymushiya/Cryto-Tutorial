//
//  CircleButtonAnimationView.swift
//  CryptoApp
//
//  Created by Benny Mushiya on 18/01/2023.
//

import SwiftUI

// this view animates the circleButton

struct CircleButtonAnimationView: View {
    
    //MARK: - PROPERTIES
    
    // this view is bound to property and upon initialisation based on the value provided for this property determines the views state.
    @Binding var animate: Bool
    
    //MARK: - BODY
    
    var body: some View {
        
        Circle()
            .stroke(lineWidth: 5)
            .scale(animate ? 1 : 0)
            .opacity(animate ? 0.0 : 1.0)
        
        // we only want to animate in one direction. thus if its true we animate  if its false we have none
            .animation(animate ? Animation.easeOut(duration: 1.0) : .none)
            .onAppear {
                
                animate.toggle()
            }
    }
}

struct CircleButtonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnimationView(animate: .constant(false))
            .foregroundColor(.red)
            .frame(width: 100, height: 100)
    }
}
