//
//  DetailsView.swift
//  CrytoWatch
//
//  Created by Raju Dhumne on 10/02/24.
//

import SwiftUI

struct DetailsView: View {
    
    
    @Binding var coin: CoinModel?
    
    init(coin: Binding<CoinModel?>) {
        self._coin = coin
    }
    
    var body: some View {
        Text(coin?.name ?? "")
    }
}

#Preview {
    DetailsView(coin: .constant(DeveloperPreview.instance.coin))
}
