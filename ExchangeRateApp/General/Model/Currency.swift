//
//  Currency.swift
//  ExchangeRateApp
//
//  Created by AlexandruGanea on 03/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import Foundation

class Currency{
    var name: String
    var value: NSNumber
    
    init(name: String, value: NSNumber){
        self.name = name
        self.value = value
    }
}
