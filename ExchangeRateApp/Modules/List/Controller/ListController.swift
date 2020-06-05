//
//  ListController.swift
//  ExchangeRateApp
//
//  Created by AlexandruGanea on 02/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import Foundation
import UIKit

class ListController {
    let exchangeService: ApiService
    let viewModel: ListViewModel
    var timer: Timer? = nil
    
    init(viewModel: ListViewModel = ListViewModel(), exchangeService: ApiService = ApiService()) {
        self.exchangeService = exchangeService
        self.viewModel = viewModel
    }
    
    func update(_ state: Update){
        timer?.invalidate()
        
        if state == .start{
            refresh()
            timer = Timer.scheduledTimer(timeInterval: Default.refreshInterval, target: self, selector: #selector(refresh), userInfo: nil, repeats: true)
        }
    }
    
    @objc func refresh(){
        viewModel.isLoading.value = true
        exchangeService.fetchRates(symbols: [], interval: 0){ [weak self] (rates) in
            self?.viewModel.isLoading.value = false
            self?.viewModel.exchangeData.value = rates
        }
    }
}
