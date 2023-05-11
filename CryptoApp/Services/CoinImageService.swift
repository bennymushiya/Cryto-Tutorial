//
//  CoinImageService.swift
//  CryptoApp
//
//  Created by Benny Mushiya on 19/01/2023.
//

import Foundation
import SwiftUI
import Combine


class CoinImageServcies {
    
    //MARK: - PROPERTIES
    
    @Published var image: UIImage? = nil
    
    private let coin: CoinModel
    
    private var imageSubscription: AnyCancellable?
    private let fileManager = LocalFileManager.instance
    
    // all the images will be saved under this coin folder name
    private let folderName = "coin_Images"
    private let imageName: String
    
    
    //MARK: - LIFECYCLE
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()

        
    }
    
    
    //MARK: - ACTION
    
    // when we call this it will check if we can get the image from the fileManager, if it does not exist from the file manager then we make an api call to download the images from the api.
    private func getCoinImage() {
        
        print("is this function working 111111")
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            
            image = savedImage
            
            print("RETRIEVED IMAGE FROM FILE MANAGER")
            
        } else {
            
            downloadCoinImage()
            print("DOWNLOADING IMAGES NOW")

        }
        
    }
    
    
    private func downloadCoinImage() {
        
        guard let url = URL(string: coin.image) else {return}
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                
                return UIImage(data: data)
            })
        
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                
                // because where using self alot so we unwrap it to make sure we have that access to self.
                guard let downloadedImage = returnedImage else {return}
                
                // we get the data and assign/append it to our published property array
                self?.image = downloadedImage
                
                // becasue this api only sends one batch of data, we cancel it after weve recieved the data so it dataTaskPublisher stops listening for any updates.
                self?.imageSubscription?.cancel()
                
                // when we download all the images from the api, we save it to file manager here inside a specific folder.
                self?.fileManager.saveImage(image: downloadedImage, imageName: self!.imageName, folderName: self!.folderName)
                //print("its saving it to file manager aswel")
                
        })
        
    }
}
