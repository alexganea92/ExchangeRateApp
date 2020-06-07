//
//  SettingViewModel.swift
//  ExchangeRateApp
//
//  Created by AlexandruGanea on 03/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import Foundation

class SettingViewModel: ViewModel{
    var isLoading = Observable<Bool>(value: false)
    var exchangeData = Observable<[Rate]>(value: [])
    var message = Observable<String?>(value: nil)
    
    lazy var controller: SettingController = {
          return SettingController()
      }()
    
    /**
      Gets the available interval options
    */
    lazy var refreshIntervals: [String] = {
        var options: [String] = []
        for value in RefreshRate.allCases{
            let str = String(value.rawValue)
            options.append(str)
        }
        return options
    }()
    
    /**
     Computes the current selectable currency  options
     - parameters:
        - exchangeData: Rate Object
     */
    func currencyNames() -> [CurrencyViewModel]{
        var currencyOptions: [CurrencyViewModel] = []
        let rateObj = exchangeData.value[exchangeData.value.count - 1]
        for value in rateObj.currencyArray {
            let currency = CurrencyViewModel.init(value)
            currencyOptions.append(currency)
        }
        return currencyOptions
    }
    
    /**
     Computes a refresh interval to be shown
     - returns:
     A formatted string
     */
    func currentRefreshInterval() -> String{
        return String(Default.refreshInterval)+" sec"
    }
}
