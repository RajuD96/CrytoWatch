//
//  LocalFileManager.swift
//  CrytoWatch
//
//  Created by Raju Dhumne on 02/02/24.
//

import Foundation
import SwiftUI

class LocalFileManager {
    
    
    static let instance = LocalFileManager()
    private init() {}
    
    func save(image: UIImage, image name: String, folderName: String) {
        // Creates folder if needed
        createFolderForImages(folderName: folderName)
        
        guard
            let data = image.pngData(),
            let url = getURLforImage(imageName: name, folderName: folderName)
        else { return }
        
        do {
            try data.write(to: url)
        } catch let error {
            print("Error Saving Image: \(name) : \(error.localizedDescription)")
        }
    }
    
    func get(image name: String, folderName: String) -> UIImage? {
        guard let url = getURLforImage(imageName: name, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
    
    private func createFolderForImages(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else {
            return
        }
        if !FileManager.default.fileExists(atPath: folderName) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("Failed to create File folder for Folder Name: \(folderName): \(error.localizedDescription)")
            }
        }
        
    }
    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(folderName)
    }
    
    private func getURLforImage(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName) else {
            return nil
        }
        return folderURL.appendingPathComponent(imageName + ".png")
    }
}
