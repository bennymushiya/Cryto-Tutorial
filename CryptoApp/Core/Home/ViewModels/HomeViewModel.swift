//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Benny Mushiya on 19/01/2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    //MARK: - PROPERTIES
    
    // published properties have a thing called subscription, where you can subscribe another property to this property. thus anything thats subscribed to this property will automaticly get updated when this property gets updated or if any changes occur. and this property is subscribed to a property inside coin services that stores all the data we recieve from the api. thus updating this propety with all the data recieved from the api.
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    //everytime a user types any letters into the search bar text this property gets updated, alongside all the other properties that subscribed to this property
    @Published var searchText: String = ""
    
    // when we initialise the CoinServices here, it will automaticly call init and fetch all the coins and assign it to our array property
    private let coinServices = CoinServices()
    private var cancellables = Set<AnyCancellable>()

    
    //MARK: - LIFECYCLE
    
    init() {
        
       addSubscribers()
        
    }
    
    //MARK: - ACTION

    func addSubscribers() {
        
        // we get the all coins published property from coin services that contains all the data recieved from the api
        // becasue weve done the same thing here below by subscribing to allCoins, we dont actaully need this but il just keep it here for vibes
        coinServices.$allCoins
        
            .sink { [weak self] returnedCoins in
                
                // we assign it to our published property
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        
        // here is where we subscribe to the publisher searchText
        $searchText
        
        // here we combine this suscriber to also be subscribe to the published property allCoins in coinServices. therefore anytime either searchText or allCoins change we will recieve the updated value
            .combineLatest(coinServices.$allCoins)
        
        // here we transform the output from both of the publishers were subscribed to into some type of data. so we transform the text and allCoin data into a final coinModel array where going to use
            .map { text, startingCoins -> [CoinModel] in
                
                // if the text is not empty then we will continue and do some filtering if it is empty then we will just return the startingCoin property
                guard !text.isEmpty else { return startingCoins }
                
                // here transfer every search text into lowercase, thus making it easer for us to filter the text
                let lowercassedText = text.lowercased()
                
                // if any of the text the user enters matches the return case below, then thats the array we will recieve, thus showing it tot he user.
                return startingCoins.filter { coin -> Bool in
                    
                    return coin.name.lowercased().contains(lowercassedText) || coin.symbol.lowercased().contains(lowercassedText) || coin.id.lowercased().contains(lowercassedText)
                }
                
            }
        
        // and everytime the published property we've subscribed to gets updated, this sink code recieves that updated published value. here we recieve the updated array based on what the user searched and we assign it to the propery allCoins above to update it.
            .sink { [weak self] returnedCoins in
                
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
}


