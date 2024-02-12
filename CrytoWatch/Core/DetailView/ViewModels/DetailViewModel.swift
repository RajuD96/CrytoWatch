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
    
    @Published var coin: CoinModel
    private let coinDetailService: CoinDetailService
    private var cancellables =  Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailService = CoinDetailService(coinId: coin.id)
    }
    
    
    private func addSubscribers() {
        coinDetailService.$coinDetailModel
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink { returnedCoinDetails in
                self.overviewStatistics = returnedCoinDetails.overview
                self.additionalStatistics = returnedCoinDetails.additional
            }
            .store(in: &cancellables)
    }
    
    
    private func mapDataToStatistics(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> (overview: [StatisticModel], additional: [StatisticModel]) {
        // Overview
        let price = coinModel.currentPrice.asCurrencyWith6Decimals()
        let pricePercentageChange = coinModel.priceChangePercentage24H
        let priceStat = StatisticModel(title: "Current Price", value: price, percentageChange: pricePercentageChange)
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentageChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercentageChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = StatisticModel(title: "Rank", value: rank)
        
        let volumne = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticModel(title: "Volume", value: volumne)
        
        let overviewArray: [StatisticModel] = [
            priceStat, marketCapStat, rankStat, volumeStat
        ]
        
        // Additional
        
        let high = coinModel.high24H?.formattedWithAbbreviations() ?? "n/a"
        let highStat = StatisticModel(title: "24 High", value: high)
        
        let low = coinModel.low24H?.formattedWithAbbreviations() ?? "n/a"
        let lowStat = StatisticModel(title: "24 Low", value: low)
        
        let priceChange = coinModel.priceChange24H?.formattedWithAbbreviations() ?? "n/a"
        let pricePercentageChange2 = coinModel.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: "24 Price Change", value: priceChange, percentageChange: pricePercentageChange2)
        
        let marketCapChange = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapChangePercentage2 = coinModel.marketCapChangePercentage24H
        
        let marketCapStat2 = StatisticModel(title: "24 Market Cap Change", value: marketCapChange, percentageChange: marketCapChangePercentage2)
        
        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = StatisticModel(title: "Block Time", value: blockTimeString)
        
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing)
        
        let additionalArray: [StatisticModel] = [
            highStat, lowStat, priceChangeStat, marketCapStat2, blockStat, hashingStat
        ]
        
        
        return (overviewArray, additionalArray)
    }
    
}
