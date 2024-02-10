//
//  CoinDetailService.swift
//  CrytoWatch
//
//  Created by Raju Dhumne on 10/02/24.
//

import Foundation
import Combine

class CoinDetailService {
    
    @Published var coinDetailModel: CoinDetailModel? = nil
    
    var coinDetailCancellable: AnyCancellable?
    
    init(coinId: String) {
        getCoinDetail(id: coinId)
    }
    
    func getCoinDetail(id: String) {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false")
        else { return }
        
       coinDetailCancellable = NetworkingManager.download(url: url)
            .decode(type: CoinDetailModel.self
                    , decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion) { [weak self] coinDetailModel in
                self?.coinDetailModel = coinDetailModel
                self?.coinDetailCancellable?.cancel()
            }
    }
    
    
}
