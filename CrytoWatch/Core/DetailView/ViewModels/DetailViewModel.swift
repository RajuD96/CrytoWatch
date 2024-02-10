//
//  DetailViewModel.swift
//  CrytoWatch
//
//  Created by Raju Dhumne on 10/02/24.
//

import Foundation
import Combine


class DetailViewModel: ObservableObject {
    
    private let coinDetailService: CoinDetailService
    
    private var cancellables =  Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coinDetailService = CoinDetailService(coinId: coin.id)
    }
    
    
    private func addSubscribers() {
        coinDetailService.$coinDetailModel
            .sink { returnedCoinDetails in
                print("Returned Coin Details")
                print(returnedCoinDetails)
            }
            .store(in: &cancellables)
    }
    
    
}
