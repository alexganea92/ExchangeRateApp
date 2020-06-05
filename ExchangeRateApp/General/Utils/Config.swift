//
//  RefreshRate.swift
//  ExchangeRateApp
//
//  Created by AlexandruGanea on 03/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import Foundation

enum RefreshRate: Int, CaseIterable {
    case low = 3
    case medium = 5
    case high = 15
}

struct Default {
    static var refreshInterval: TimeInterval = TimeInterval(RefreshRate.low.rawValue)
    static var currencyBase: String = "EUR"
}
