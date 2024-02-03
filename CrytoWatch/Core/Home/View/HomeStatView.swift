//
//  HomeStatView.swift
//  CrytoWatch
//
//  Created by Raju Dhumne on 03/02/24.
//

import SwiftUI

struct HomeStatView: View {
    
    @EnvironmentObject var homeVM: HomeViewModel
    @Binding var showPortfolio: Bool
    
    var body: some View {
        HStack {
            ForEach(homeVM.statictis) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
    }
}

#Preview {
    HomeStatView(showPortfolio: .constant(false))
        .environmentObject(DeveloperPreview.instance.homeVM)
}
