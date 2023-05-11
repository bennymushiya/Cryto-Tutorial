//
//  RowColumns.swift
//  CryptoApp
//
//  Created by Benny Mushiya on 19/01/2023.
//

import SwiftUI


//MARK: - LEFT COLUMN

struct LeftColumns: View {
    
    //MARK: - PROPERTIES
    
    let coin: CoinModel

    //MARK: - BODY
    
    var body: some View {
        
        HStack(spacing: 0) {
            
            // left side properties
            
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 30)
            
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
                
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(Color.theme.accent)
            
        }
    }
}


//MARK: - CENTRE COLUMN

struct CentreColumns: View {
    
    //MARK: - PROPERTIES

    let coin: CoinModel
    
    //MARK: - BODY

    var body: some View {
        
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
            Text((coin.currentHoldings ?? 0).asNumberString())
            
        }
        .foregroundColor(Color.theme.accent)
    }
}


//MARK: - RIGHT COLUMN

struct RightColumns: View {
    
    //MARK: - PROPERTIES
    
    let coin: CoinModel
    
    //MARK: - BODY

    var body: some View {
       
        // right side properties
        VStack(alignment: .trailing) {
            
            Text("\(coin.currentPrice.asCurrencyWith6Decimals())")
                .bold()
                .foregroundColor(Color.theme.accent)
            
            Text(coin.priceChangePercentage24HInCurrency?.asPercentageString() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24HInCurrency ?? 0) >= 0 ? Color.theme.green : Color.theme.red
                )
        }
        
        // we are only okay with using uiscreen becasue our app will only be used in portrait mode. if we were using landscape mode aswel, then we should use a geometry reader
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}


//MARK: - ALL COIN LISTS

struct AllCoinLists: View {
    
    //MARK: - PROPERTIES
    
     var viewModel: HomeViewModel
    
    //MARK: - BODY

    var body: some View {
       
        List {
            
            ForEach(viewModel.allCoins) { coin in
                
                CoinRowView(coin: coin, showHoldingsColumn: false)
                
                // adds padding to the lists
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
            
        }
        .listStyle(.plain)
    }
}


//MARK: - PORTFOLIO COINT LIST

struct PortfolioCoinLists: View {
    
    //MARK: - PROPERTIES
    
     var viewModel: HomeViewModel
    
    //MARK: - BODY

    var body: some View {
       
        List {
            
            ForEach(viewModel.portfolioCoins) { coin in
                
                CoinRowView(coin: coin, showHoldingsColumn: true)
                
                // adds padding to the lists
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
            
        }
        .listStyle(.plain)
    }
}


//MARK: - COLUMN TITLES

struct ColumnTitles: View {
    
    //MARK: - PROPERTIES
    
     @Binding var showPortfolio: Bool
    
    //MARK: - BODY

    var body: some View {
       
        HStack {
            
            Text("Coin")
            
            Spacer()
            
            if showPortfolio {
                
                Text("Holdings")

            }
            
            Text("Price ")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}


struct RowColumns_Previews: PreviewProvider {
    static var previews: some View {
        
        LeftColumns(coin: dev.coin)
    }
}
