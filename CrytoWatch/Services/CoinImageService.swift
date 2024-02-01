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
    
    init(coin: CoinModel) {
        self.coin = coin
        getImage()
    }
    
    private func getImage() {
        guard let url = URL(string: coin.image)
        else { return }
        
        imageSubscriptionCancellable = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: {[weak self] (returnedImage) in
                self?.image = returnedImage
                self?.imageSubscriptionCancellable?.cancel()
            })
    }
}
