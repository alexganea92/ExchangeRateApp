//
//  HistoryController.swift
//  ExchangeRateApp
//
//  Created by AlexandruGanea on 04/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import Foundation

class HistoryController {
    let exchangeService: ApiService
    let viewModel: HistoryViewModel
    
    
    init(viewModel: HistoryViewModel = HistoryViewModel(), exchangeService: ApiService = ApiService()) {
        self.exchangeService = exchangeService
        self.viewModel = viewModel
    }
    
    func update(){
        exchangeService.fetchRates(symbols:["RON", "USD", "BGN"], interval: -10){ [weak self] (rates) in
            self?.viewModel.exchangeDataArray.value = rates
        }
    }
    
}
