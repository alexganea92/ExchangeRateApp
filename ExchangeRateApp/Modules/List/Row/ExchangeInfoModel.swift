//
//  ExchangeInfoModel.swift
//  ExchangeRateApp
//
//  Created by AlexandruGanea on 03/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import Foundation

class ExchangeInfoModel{
    var information: String? = nil
    
    init(_ currency: Currency) {
        information = String(currency.name + " " + Helper.sharedInstance.numberFormatter.string(from: currency.value)!)
    }
    
}
