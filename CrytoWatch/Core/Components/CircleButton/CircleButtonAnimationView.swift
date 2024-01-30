//
//  CircleButtonAnimation.swift
//  CrytoWatch
//
//  Created by Raju Dhumne on 28/01/24.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? .easeOut(duration: 1) : .none, value: animate ? 1.0 : 0.0)
    }
}

#Preview {
    CircleButtonAnimationView(animate: .constant(false))
}
