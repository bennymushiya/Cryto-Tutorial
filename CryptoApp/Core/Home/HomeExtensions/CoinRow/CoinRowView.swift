//
//  CoinRowView.swift
//  CryptoApp
//
//  Created by Benny Mushiya on 18/01/2023.
//

import SwiftUI

struct CoinRowView: View {
    
    //MARK: - PROPERTIES
    
    let coin: CoinModel
    let showHoldingsColumn: Bool
    
    
    //MARK: - BODY
    
    var body: some View {
        
        HStack(spacing: 0) {
            
            LeftColumns(coin: coin)
            
            Spacer()
            
            if showHoldingsColumn {
                
                CentreColumns(coin: coin)
            }
            
            RightColumns(coin: coin)
            
        }
        .font(.subheadline)
        
    }
}


struct CoinRowView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        CoinRowView(coin: dev.coin, showHoldingsColumn: true)
        
    }
}

