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
    @State var showFullDescription: Bool = false
    
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
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                VStack {
                    overviewTitle
                    Divider()
                    descriptionSection
                    overviewGrid
                    additionalTitle
                    Divider()
                    additionalGrid
                    websiteSection
                  
                    
                }
                .padding()
            }
        }
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                navigationBarTrailingItems
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailsView(coin: DeveloperPreview.instance.coin)
    }
}


extension DetailsView {
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
    }
    
    private var additionalTitle: some View {
        
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
    }
    
    private var descriptionSection: some View {
        ZStack {
            if let description = vm.coinDescription {
                if !description.isEmpty {
                    VStack(alignment: .leading) {
                        Text(description)
                            .lineLimit(showFullDescription ? nil : 3)
                            .font(.callout)
                            .foregroundStyle(Color.theme.secondaryTextColor)
                        
                        Button(action: {
                            
                            withAnimation(.easeInOut) {
                                showFullDescription.toggle()
                            }
                            
                        }, label: {
                            Text(showFullDescription ? "Less" : "Read More..")
                                .font(.caption)
                                .fontWeight(.bold)
                                .padding(.vertical, 4)
                        })
                        .accentColor(.blue)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
    
    private var overviewGrid: some View {
        LazyVGrid(columns: colums, alignment: .leading, spacing: spacing, content: {
            
            ForEach(vm.overviewStatistics) { stat in
                StatisticView(stat: stat)
            }
        })
    }
    
    private var additionalGrid: some View {
        LazyVGrid(columns: colums, alignment: .leading, spacing: spacing, content: {
            
            ForEach(vm.additionalStatistics) { stat in
                StatisticView(stat: stat)
            }
        })
    }
    
    private var websiteSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let websiteURL = vm.websiteURL {
                if let url = URL(string: websiteURL) {
                    Link("Websire", destination: url)
                }
                
                if let redditURL = vm.redditURL {
                    if let url = URL(string: redditURL) {
                        Link("Reddit", destination: url)
                    }
                }
                
            }
        }
        .accentColor(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
    }
    
    private var navigationBarTrailingItems: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
            .foregroundStyle(Color.theme.secondaryTextColor)
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
}
