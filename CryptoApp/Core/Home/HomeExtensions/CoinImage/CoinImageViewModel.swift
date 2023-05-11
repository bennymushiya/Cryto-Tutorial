//
//  CoinImageViewModel.swift
//  CryptoApp
//
//  Created by Benny Mushiya on 21/01/2023.
//

import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    
    //MARK: - PROPERTIES

    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    // we pass in a coin to this viewModel
    private let coin: CoinModel
    private let imageServices: CoinImageServcies
    private var cancellables = Set<AnyCancellable>()
    
    
    //MARK: - LIFECYCLE

    init(coin: CoinModel) {
        self.coin = coin
        
        // and we initialise the coinImage service here, whihc in turn initialises in coinImageServices with a string that we pass here and downloads the data from the api etc
        self.imageServices = CoinImageServcies(coin: coin)
        self.addsubscribers()
        self.isLoading = true
        
    }
    
    
    //MARK: - ACTION

    private func addsubscribers() {
        
        imageServices.$image
        
        // we put an under score when we dont need to use the completion
            .sink { [weak self] _ in
                
                self?.isLoading = false
                
            } receiveValue: { [weak self] returnedImage in
                
                self?.image = returnedImage
            }
            .store(in: &cancellables)

        
    }
    
}
