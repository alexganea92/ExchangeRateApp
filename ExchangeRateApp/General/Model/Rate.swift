//
//  Rate.swift
//  ExchangeRateApp
//
//  Created by AlexandruGanea on 02/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import Foundation

class Rate{
    var date: String
    var base: String
    var currencyArray = [Currency]()
    
    init(date: String, base: String, rates: [String:NSNumber]) {
        self.date = date
        self.base = base
        
        let sortedDict = rates.sorted(by: { $0.0 < $1.0 })
        
        for (key, value) in sortedDict{
            let currency = Currency.init(name: key, value: value)
            currencyArray.append(currency)
        }
    }
}
