//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Benny Mushiya on 18/01/2023.
//

import SwiftUI


// this is the first file that runs in our app. so whatever view we call here will show in the phone/simulator
@main
struct CryptoAppApp: App {
    
    //MARK: - PROPERTIES

    @StateObject private var viewModel = HomeViewModel()
    
    
    //MARK: - BODY
    
    var body: some Scene {
        WindowGroup {
            
            // this is how we embed our whole app in a navigation view
            NavigationView {
                
                HomeView()
                    .navigationBarHidden(true)
                
            }
            
            // by initialising this viewModel as an environmentObject it gives every view thats inside this environment access to this viewModel
            .environmentObject(viewModel)
            
            
        }
    }
}
