//
//  NetworkingManager.swift
//  CryptoApp
//
//  Created by Benny Mushiya on 20/01/2023.
//

import Foundation
import Combine

// we can use this networking manager everytime we make an api request and reuse it over and over 
class NetworkingManager {
    
    //MARK: - ERROR HANDLING

    enum NetworkingError: LocalizedError {
        
        case badURLResponse(url: URL)
        case unkown
        
        var errorDescription: String? {
            
            switch self {
                
            case .badURLResponse(url: let url): return "[🔥] Bad response from URL \(url)"
                
            case .unkown: return " [⚠️] Unknown error occured"
                
            }
            
        }
    }
    
    
    
    //MARK: - RECIEVING DATA FROM API
    
    // we create a static function because it will become a singleton that we reuse over and over without having to inititalise it when called.
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        
        // dataTaskPublisher assumes the url will continue to send us data over time, thus its continously listening in case we have more values from the url.
      return URLSession.shared.dataTaskPublisher(for: url)
         
         // the dataTask runs on background thread by default. but where just making sure its actaully doing that.
             .subscribe(on: DispatchQueue.global(qos: .default))
         
         // we mapp through the data we recieve and check for a good response
             .tryMap({ try handleURLResponse(outPut: $0, url: url)})
         
         //we go back on our main thread and decode the data we recieve from a json format into our model we created
             .receive(on: DispatchQueue.main)
        
        // this line of code takes the above publisher and converts it to any publisher that needs to be returned
             .eraseToAnyPublisher()
        
    }
    
    
    //MARK: - HANDLING RESPONSE

    // handles the response into a reusable function for cleaner code
    static func handleURLResponse(outPut: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        
        // if response is equal to or greater than 200 and if response is small than 300 then we get the data back, else we through an error
        guard let response = outPut.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            
            throw NetworkingError.badURLResponse(url: url)
        }
        
        return outPut.data
    }
    
    
    //MARK: - HANDLING COMPLETION
    
    // this is our completion handler for our api call where we handle the data
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        
        // if theres an error it will print out the error
            switch completion {
                
            case .finished: break
                
            case .failure(let error):
                
                print(error.localizedDescription)
            }
            
        }
    
}
