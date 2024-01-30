//
//  CrytoWatchApp.swift
//  CrytoWatch
//
//  Created by Raju Dhumne on 26/01/24.
//

import SwiftUI

@main
struct CrytoWatchApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
            }
            .environmentObject(vm)
            .toolbar(.hidden)
            
        }
    }
}
