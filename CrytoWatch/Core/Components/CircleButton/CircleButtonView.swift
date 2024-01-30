//
//  CircleButtonView.swift
//  CrytoWatch
//
//  Created by Raju Dhumne on 27/01/24.
//

import SwiftUI

struct CircleButtonView: View {
    
    let imageName: String
    
    var body: some View {
        Image(systemName: imageName)
            .font(.headline)
            .foregroundColor(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundStyle(Color.theme.background)
            )
            .shadow(color: Color.theme.accent.opacity(0.25),
                    radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 0)
            .padding()
    }
}

#Preview {
    CircleButtonView(imageName: "info")
        .previewLayout(.sizeThatFits)
}
