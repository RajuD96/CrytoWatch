//
//  DetailsView.swift
//  CrytoWatch
//
//  Created by Raju Dhumne on 10/02/24.
//

import SwiftUI

struct DetailsLoadingView: View {
    
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailsView(coin: coin)
            }
        }
    }
}


struct DetailsView: View {
    
    @StateObject private var vm: DetailViewModel
    
    let coin: CoinModel
    
    init(coin: CoinModel) {
        
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        self.coin = coin
    }
    
    var body: some View {
        Text(coin.name)
    }
}

#Preview {
    DetailsView(coin: DeveloperPreview.instance.coin)
}
