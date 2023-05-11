//
//  HomeView.swift
//  CryptoApp
//
//  Created by Benny Mushiya on 18/01/2023.
//

import SwiftUI

struct HomeView: View {
    
    //MARK: - PROPERTIES
    
    @EnvironmentObject private var viewModel: HomeViewModel
    
    @State private var showPortfolio = false
        
    //MARK: - BODY
    
    var body: some View {
        
        ZStack {
            
            // background layer
            
            Color.theme.background
                .ignoresSafeArea()
            
            // header layer
            VStack {
                
                HomeHeader(showPortfolio: $showPortfolio)
                
                SearchBarView(searchText: $viewModel.searchText)
                
                ColumnTitles(showPortfolio: $showPortfolio)
                
                if !showPortfolio {
                    
                    PortfolioCoinLists(viewModel: viewModel)
                        .transition(.move(edge: .trailing))
                    
                  
                    
                }
                   
                if showPortfolio {
                    
                    AllCoinLists(viewModel: viewModel)
                    .transition(.move(edge: .leading))
                   
                }
              
                
                Spacer(minLength: 0)
            }
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
            
        }
        .environmentObject(dev.homeVM)
    }
}




