//
//  SettingsView.swift
//  CrytoWatch
//
//  Created by Raju Dhumne on 18/02/24.
//

import SwiftUI

struct SettingsView: View {
    
    let personalURL = URL(string: "https://github.com/rajudhumne")!
    
    var body: some View {
        NavigationView {
            List {
               swiftfulThinkingSection
            developerSection
            }
        }
        .font(.headline)
        .accentColor(.blue)
        .listStyle(GroupedListStyle())
        .navigationTitle("Settings")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                XMarkButton()
            }
        }
    }
}

#Preview {
    NavigationView {
        SettingsView()
    }
}

extension SettingsView {
    
    
    private var swiftfulThinkingSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width:100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Text("This app was made by following a @SwiftfulThinking course on Youtube. It uses MVVM Architecture, Combine, and CoreData!!")
            }
            .padding(.vertical)
        } header: {
            Text("Crypto Watch App")
        }
    }
    
    private var developerSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("githubLogo")
                    .resizable()
                    .frame(width:100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Text("This app was made by Raju Dhumne. It uses Swiftful and is written 100% in Swift. The project benefits from multi-threading, publishers/subscribers, and data persistence.")
            }
            .padding(.vertical)
            Link("Visit Portfolio 💼", destination: personalURL)
        } header: {
            Text("Developer")
        }
    }
    
}
