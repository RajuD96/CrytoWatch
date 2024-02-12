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
    
    private var colums: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private let spacing: CGFloat = 30
    
    init(coin: CoinModel) {
        
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        self.coin = coin
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("")
                    .frame(height: 150)
                
                Text("Overview")
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color.theme.accent)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    
                
                Divider()
                
                LazyVGrid(columns: colums, alignment: .leading, spacing: spacing, content: {
                    
                    ForEach(0..<6) { _ in
                        StatisticView(stat: StatisticModel(title: "Title", value: "Value"))
                    }
                })
                
                Text("Additional Details")
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color.theme.accent)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                
                Divider()
                
                LazyVGrid(columns: colums, alignment: .leading, spacing: spacing, content: {
                    
                    ForEach(vm.overviewStatistics) { stat in
                        StatisticView(stat: stat)
                    }
                })
                
            }
            .padding()
            
        }
        .navigationTitle(vm.coin.name)
    }
}

#Preview {
    NavigationStack {
        DetailsView(coin: DeveloperPreview.instance.coin)
    }
}
