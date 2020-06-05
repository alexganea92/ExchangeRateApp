//
//  SettingController.swift
//  ExchangeRateApp
//
//  Created by AlexandruGanea on 03/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import Foundation

class SettingController{
    let exchangeService: ApiService
    let viewModel: SettingViewModel
    
    
    init(viewModel: SettingViewModel = SettingViewModel(), exchangeService: ApiService = ApiService()) {
        self.exchangeService = exchangeService
        self.viewModel = viewModel
    }
    
    func update(){
        viewModel.isLoading.value = true
        exchangeService.fetchRates(symbols: [], interval: 0){ [weak self] (rates) in
            self?.viewModel.isLoading.value = false
            if rates.count > 0{
                self?.viewModel.setCurrencyNames(exchangeData: rates[rates.count-1])
            }
        }
    }
}
