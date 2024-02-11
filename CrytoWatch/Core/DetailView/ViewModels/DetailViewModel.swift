//
//  DetailViewModel.swift
//  CrytoWatch
//
//  Created by Raju Dhumne on 10/02/24.
//

import Foundation
import Combine


class DetailViewModel: ObservableObject {
    
    @Published var overviewStatistics: [StatisticModel] = []
    @Published var additionalStatistics: [StatisticModel] = []
    
    let coin: CoinModel
    private let coinDetailService: CoinDetailService
    private var cancellables =  Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailService = CoinDetailService(coinId: coin.id)
    }
    
    
    private func addSubscribers() {
        coinDetailService.$coinDetailModel
            .map({ coinDetailModel -> (overview: [StatisticModel], additional: [StatisticModel]) in
                
                return ([], [])
            })
            .sink { returnedCoinDetails in
                print("Returned Coin Details")
                print(returnedCoinDetails)
            }
            .store(in: &cancellables)
    }
    
    
}
