//
//  CoinImageView.swift
//  CryptoApp
//
//  Created by Benny Mushiya on 19/01/2023.
//

import SwiftUI

struct CoinImageView: View {
    
    //MARK: - PROPERTIES
    
    @StateObject var viewModel: CoinImageViewModel
    
    
    //MARK: - LIFECYCLE
    
    // because the viewModel needs a coin model upon initialisation, to access that coin we initialise this view with a coin and rather than initialising the viewModel below we initialise it inside the init so it has access to that coin
    init(coin: CoinModel) {
        
        // we need an underscore to reference the stateObject of the viewmodel
        _viewModel = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }

    
    //MARK: - BODY
    
    var body: some View {
        
        ZStack {
            
            if let image = viewModel.image {
                
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                
            } else if viewModel.isLoading {
                
                ProgressView()
                
            } else {
                
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.secondaryText)
            }
        }
        
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
            .padding()
            
    }
}
