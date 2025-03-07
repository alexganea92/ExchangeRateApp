//
//  SettingController.swift
//  ExchangeRateApp
//
//  Created by AlexandruGanea on 03/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import Foundation

class SettingController: Updatable{
    let exchangeService: APIServiceProtocol
    let viewModel: SettingViewModel
    
    
    init(viewModel: SettingViewModel = SettingViewModel(), exchangeService: APIServiceProtocol = ApiService()) {
        self.exchangeService = exchangeService
        self.viewModel = viewModel
    }
    
    func update(){
        viewModel.isLoading.value = true
        exchangeService.fetchRates(symbols: [], interval: 0){ [weak self] (rates, error) in
            self?.viewModel.isLoading.value = false
            
            if let errorMsg = error?.localizedDescription {
                self?.viewModel.message.value = errorMsg
            }else{
                if rates.count > 0{
                    self?.viewModel.exchangeData.value = rates
                }
            }
        }
    }
}
