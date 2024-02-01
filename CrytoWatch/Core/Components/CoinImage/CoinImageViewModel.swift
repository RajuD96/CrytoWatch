//
//  CoinImageViewModel.swift
//  CrytoWatch
//
//  Created by Raju Dhumne on 01/02/24.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject{
    @Published var image: UIImage?
    @Published var isLoading: Bool = false
    
    private let coin: CoinModel
    private let dataService: CoinImageService
    private var cancellable = Set<AnyCancellable>()
    
    
    init(coin: CoinModel) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.addSubscriber()
    }
    
    private func addSubscriber() {
        dataService.$image
            .sink { [weak self] (_) in
                self?.isLoading = true
            } receiveValue: { [weak self] returnedImage in
                self?.isLoading = false
                self?.image = returnedImage
            }
            .store(in: &cancellable)

    }
}
