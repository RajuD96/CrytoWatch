//
//  CoinImageService.swift
//  CrytoWatch
//
//  Created by Raju Dhumne on 01/02/24.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage?
    private var imageSubscriptionCancellable: AnyCancellable?
    private let coin: CoinModel
    private let localFileManager = LocalFileManager.instance
    private let folderName = "CoinImagesFileManager"
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let image = localFileManager.get(image: coin.id, folderName: folderName) {
            print("Retriveing from file manager")
            self.image = image
        } else {
            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage() {
        print("Downloading Image from Server")
        guard let url = URL(string: coin.image)
        else { return }
        
        imageSubscriptionCancellable = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: {[weak self] (returnedImage) in
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = downloadedImage
                self.imageSubscriptionCancellable?.cancel()
                self.localFileManager.save(image: downloadedImage, image: coin.id, folderName: folderName)
            })
    }
}
