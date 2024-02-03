//
//  HomeViewModel.swift
//  CrytoWatch
//
//  Created by Raju Dhumne on 28/01/24.
//

import Foundation
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statictis: [StatisticModel] = [
        StatisticModel(title: "Market Cap", value: "$12.5Bn", percentageChange: 25.34),
        StatisticModel(title: "Market Cap", value: "$12.5Bn", percentageChange: 25.34),
        StatisticModel(title: "Total Volume", value: "$1.23Tr"),
        StatisticModel(title: "Portfolio Value", value: "$50.4k", percentageChange: -12.34)
    ]
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    @Published var searchText: String = ""
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] ( returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        marketDataService.$marketData
            .map { (marketDataModel) -> [StatisticModel] in
                var stats: [StatisticModel] = []
                let marketCap = StatisticModel(title: "Market Cap", 
                                               value: marketDataModel?.marketCap ?? "",
                                               percentageChange: marketDataModel?.marketCapChangePercentage24HUsd)
                
                let volume = StatisticModel(title: "Volume", value: marketDataModel?.volume ?? "")
                let btcDominance = StatisticModel(title: "BTC Dominance", value: marketDataModel?.btcDominance ?? "")
                let portfolio = StatisticModel(title: "Portfolio", value: "$0.00", percentageChange: 0)
                
                stats.append(contentsOf: [marketCap, volume, btcDominance, portfolio])
                return stats
            }
            .sink { [weak self] (returnedStats) in
                self?.statictis = returnedStats
            }
            .store(in: &cancellables)
        
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        let lowerCaseText = text.lowercased()
        return coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowerCaseText)
                || coin.id.lowercased().contains(lowerCaseText) || coin.symbol.lowercased().contains(lowerCaseText)
        }
    }
    
}
