//
//  MarketDataService.swift
//  CrytoWatch
//
//  Created by Raju Dhumne on 03/02/24.
//

import Foundation
import Combine


class MarketDataService {
    
    
    @Published var marketData: MarketDataModel? = nil
    
    var marketubscription: AnyCancellable?
    
    init() {
        getData()
    }
    
    private func getData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global")
        else { return }
        
        marketubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: {[weak self] (returnedMarketData) in
                self?.marketData = returnedMarketData.data
                self?.marketubscription?.cancel()
            })
    }
}



