//
//  HomeView.swift
//  CrytoWatch
//
//  Created by Raju Dhumne on 27/01/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            VStack {
                Text("Header")
                Spacer(minLength: 0)
            }
        }
    }
}

#Preview {
    NavigationView {
        HomeView()
    }.toolbar(.hidden)
}
