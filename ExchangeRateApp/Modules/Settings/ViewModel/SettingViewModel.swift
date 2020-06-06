//
//  SettingViewModel.swift
//  ExchangeRateApp
//
//  Created by AlexandruGanea on 03/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import Foundation

class SettingViewModel{
    let isLoading = Observable<Bool>(value: false)
    var currencyOptions: [CurrencyViewModel] = []
    
    lazy var controller: SettingController = {
          return SettingController()
      }()
    
    lazy var refreshIntervals: [String] = {
        var options: [String] = []
        for value in RefreshRate.allCases{
            let str = String(value.rawValue)
            options.append(str)
        }
        return options
    }()
    
    func setCurrencyNames(exchangeData: Rate){
        currencyOptions.removeAll()
        
        for value in exchangeData.currencyArray {
            let currency = CurrencyViewModel.init(value)
            currencyOptions.append(currency)
        }
    }
    
    func currentRefreshInterval() -> String{
        return String(Default.refreshInterval)+" sec"
    }
}
