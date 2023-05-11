//
//  LocalFileManager.swift
//  CryptoApp
//
//  Created by Benny Mushiya on 21/01/2023.
//

import Foundation
import SwiftUI


class LocalFileManager {
    
    
    //MARK: - PROPERTY

    // this is the single instance were gonna use to initialise this class to use throughout our entire app
    static let instance = LocalFileManager()
    
    
    
    //MARK: - LIFECYCLE
    
    private init() { }
    
    
    
    //MARK: - FOLDER CREATION AND SAVE IMAGE
    
    // we cant save the image directly to the file manager but we can save the data for the image to the file manager
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        
        // create folder
        createFolderIfNeeded(folderName: folderName)
        
        // get path for image
        guard
            let data = image.pngData(),
            let url = getUrlforImage(imageName: imageName, folderName: folderName)
        else {return}
        
        // save image to path
        // here we catch the error becasue this line of code tends to throw errors so we need to catch it if it does.
        do {
            
            try data.write(to: url)
            
            print("successfully saved the image to file mamanger")

        } catch let error{
            
            
            print("DEBUGG: WE FAILED TO SAVE THE IMAGE: \(imageName) \(error)")
            
        }
        
    }
    
    
    // before we call the other functions we first need to check if the folder already exists, if not we create one.
    private func createFolderIfNeeded(folderName: String) {
        
        guard let url = getURLForFolder(folderName: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            
            do {
                
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
                
            } catch let error {
                
                print("DEBUGG: ERROR CREATING THE FILE DIRECTORY: \(folderName) \(error.localizedDescription)")
            }
        }
        
    }
    
    // here we create the url for the foler that will be saving our images
    private func getURLForFolder(folderName: String) -> URL? {
        
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        
        return url.appendingPathComponent(folderName)
        
    }
    
    
    // we access the folderUrl directory and save our image inside that folder
    private func getUrlforImage(imageName: String, folderName: String) -> URL? {
        
        guard let folderName = getURLForFolder(folderName: folderName) else { return nil }
        
        return folderName.appendingPathComponent(imageName + ".png")
        
    }
    
    
    //MARK: - FETCH IMAGE
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        
        guard
            let url = getUrlforImage(imageName: imageName, folderName: imageName),
            FileManager.default.fileExists(atPath: url.path)
                
        else { return nil }
        
        return UIImage(contentsOfFile: url.path)
        
    }

    

}
