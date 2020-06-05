//
//  Helper.swift
//  ExchangeRateApp
//
//  Created by AlexandruGanea on 03/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import Foundation

enum Update{
    case start, stop
}

class Helper{
    static let sharedInstance = Helper()
    
    let numberFormatter = NumberFormatter()
    let dateFormatter = DateFormatter()
    
    init() {
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
}
