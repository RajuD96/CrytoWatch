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
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
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
        
        
        $allCoins
            .combineLatest(portfolioDataService.$savedEntites)
            .map { (coinModels, portfolioEntites) in
                coinModels
                    .compactMap { (coin) -> CoinModel? in
                        guard let entity = portfolioEntites.first(where: { $0.coinID == coin.id}) else {
                            return nil
                        }
                        return coin.updateHoldings(amount: entity.amount)
                    }
            }
            .sink {[weak self] (returnedCoins) in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.isLoading = false
                self?.statictis = returnedStats
            }
            .store(in: &cancellables)
        
        
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
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
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        let marketCap = StatisticModel(title: "Market Cap",
                                       value: marketDataModel?.marketCap ?? "",
                                       percentageChange: marketDataModel?.marketCapChangePercentage24HUsd)
        
        let volume = StatisticModel(title: "Volume", value: marketDataModel?.volume ?? "")
        let btcDominance = StatisticModel(title: "BTC Dominance", value: marketDataModel?.btcDominance ?? "")
        
        let portfolioValue = portfolioCoins
                                .map { $0.currentHoldingsValue}
                                .reduce(0, +)
        
        
        let previousValue = portfolioCoins
                                .map { coin -> Double in
                                    let currentValue = coin.currentHoldingsValue
                                    let percentChange = coin.priceChangePercentage24H ?? 0 / 100
                                    let previousValue = currentValue / (1 + percentChange)
                                    return previousValue
                                }
                                .reduce(0, +)
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        
        
        let portfolio = StatisticModel(title: "Portfolio", value: portfolioValue.asCurrencyWith6Decimals(), percentageChange: percentageChange)
        
        stats.append(contentsOf: [marketCap, volume, btcDominance, portfolio])
        return stats
    }
    
}
