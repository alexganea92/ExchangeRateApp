//
//  HistoryController.swift
//  ExchangeRateApp
//
//  Created by AlexandruGanea on 04/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import Foundation

class HistoryController: Updatable {
    let exchangeService: APIServiceProtocol
    let viewModel: HistoryViewModel
    
    
    init(viewModel: HistoryViewModel = HistoryViewModel(), exchangeService: APIServiceProtocol = ApiService()) {
        self.exchangeService = exchangeService
        self.viewModel = viewModel
    }
    
    func update(){
        exchangeService.fetchRates(symbols:["RON", "USD", "BGN"], interval: -10){ [weak self] (rates, error) in
            if let errorMsg = error?.localizedDescription {
                self?.viewModel.message.value = errorMsg
            }else{
                self?.viewModel.exchangeData.value = rates
            }
        }
    }
    
}
