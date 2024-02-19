//
//  Color.swift
//  CrytoWatch
//
//  Created by Raju Dhumne on 26/01/24.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
    static let launch = ColorTheme()
}

struct ColorTheme {
    
    let accent = Color("AccentColor")
    let green = Color("AppGreenColor")
    let red = Color("AppRedColor")
    let background = Color("BackgroundColor")
    let secondaryTextColor = Color("SecondaryTextColor")
    
}


struct LaunchTheme {
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")
}
