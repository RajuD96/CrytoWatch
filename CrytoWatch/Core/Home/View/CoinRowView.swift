//
//  CoinRowView.swift
//  CrytoWatch
//
//  Created by Raju Dhumne on 28/01/24.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    let showHoldingColumn: Bool
    
    var body: some View {
        HStack {
            leftColumn
            Spacer()
            if showHoldingColumn {
              middleColumn
            }
            rightColumn
        }
        .font(.subheadline)
        .background {
            Color.theme.background.opacity(0.001)
        }
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            CoinRowView(coin: dev.coin, showHoldingColumn: true)
                .previewLayout(.sizeThatFits)
            
            
            
            CoinRowView(coin: dev.coin, showHoldingColumn: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
        
        
    }
}


extension CoinRowView {
    
    private var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.accent)
                .frame(minWidth: 20)
            CoinImageView(coin: coin)
                .frame(width: 40, height: 40)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundStyle(Color.theme.accent)
        }
    }
    
    private var middleColumn: some View {
        VStack(alignment: .trailing) {
            Text("\(coin.currentHoldingsValue.asCurrencyWith6Decimals())")
                .bold()
                .foregroundStyle(Color.theme.accent)
            
            Text("\(coin.currentHoldings?.asNumberString() ?? "")")
            
                .foregroundStyle(Color.theme.accent)
        }
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text("\(coin.currentPrice.asCurrencyWith2Decimals())")
                .bold()
                .foregroundStyle(Color.theme.accent)
            
            Text("\(coin.priceChangePercentage24H?.asPercentString() ?? "")")
                .foregroundStyle(
                    (coin.priceChangePercentage24H ?? 0 >= 0 ) ?
                    Color.theme.green :
                    Color.theme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
    
}
