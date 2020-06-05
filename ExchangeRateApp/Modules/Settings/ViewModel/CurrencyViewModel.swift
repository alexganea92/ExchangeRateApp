//
//  CurrencyViewModel.swift
//  ExchangeRateApp
//
//  Created by AlexandruGanea on 03/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import Foundation

class CurrencyViewModel{
    var name: String? = nil
    
    init(_ currency:Currency) {
        name = currency.name
    }
}
