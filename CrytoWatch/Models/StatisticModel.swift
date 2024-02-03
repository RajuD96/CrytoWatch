//
//  StatisticModel.swift
//  CrytoWatch
//
//  Created by Raju Dhumne on 03/02/24.
//

import Foundation

struct StatisticModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.value = value
        self.title = title
        self.percentageChange = percentageChange
    }
}
