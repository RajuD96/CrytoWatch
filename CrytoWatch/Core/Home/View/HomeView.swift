//
//  HomeView.swift
//  CrytoWatch
//
//  Created by Raju Dhumne on 27/01/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var homeVM: HomeViewModel
    @State private var showPortfolio: Bool = false
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            VStack {
                homeHeader
                
                SearchBarView(searchText: $homeVM.searchText)
                
                columnTitles
                
                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }
                
                if showPortfolio {
                    portfolioList
                        .transition(.move(edge: .trailing))
                }
                
                Spacer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .toolbar(.hidden)
        }
        .environmentObject(DeveloperPreview.instance.homeVM)
    }
}


extension HomeView {
    private var homeHeader: some View {
        HStack{
            CircleButtonView(imageName: showPortfolio ? "plus" : "info")
                .background {
                    CircleButtonAnimationView(animate: $showPortfolio)
                }
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(imageName: "chevron.right")
                .onTapGesture {
                    withAnimation(.spring) {
                        showPortfolio.toggle()
                    }
                }
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
        }
        .padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        List {
            ForEach(homeVM.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: false)
                    .listRowInsets(.init(top: 0, leading: 10, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
    private var portfolioList: some View {
        List {
            ForEach(homeVM.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: false)
                    .listRowInsets(.init(top: 0, leading: 10, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
    private var columnTitles: some View {
        HStack {
            Text("Coin")
            Spacer()
            if showPortfolio {
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryTextColor)
        .padding(.horizontal)
    }
}
