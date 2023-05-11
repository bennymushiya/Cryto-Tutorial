//
//  CoinServices.swift
//  CryptoApp
//
//  Created by Benny Mushiya on 19/01/2023.
//

import Foundation
import Combine

class CoinServices {
    
    //MARK: - PROPERTIES
    
    @Published var allCoins: [CoinModel] = []
    var coinSubscription: AnyCancellable?
    
    
    
    //MARK: - LIFECYCLE

    init() {
        getCoins()
        
    }
    
    
    //MARK: - ACTION

    private func getCoins() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else {return}
        
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
        
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
                
                // we get the data and assign/append it to our published property array
                self?.allCoins = returnedCoins
                
                // becasue this api only sends one batch of data, we cancel it after weve recieved the data so it dataTaskPublisher stops listening for any updates.
                self?.coinSubscription?.cancel()
        })
        
    }
    
}
