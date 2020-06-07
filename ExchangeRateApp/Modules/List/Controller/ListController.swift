//
//  ListController.swift
//  ExchangeRateApp
//
//  Created by AlexandruGanea on 02/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import Foundation
import UIKit

class ListController: Updatable {
    
    let exchangeService: APIServiceProtocol
    let viewModel: ListViewModel
    var timer: Timer? = nil
    
    init(viewModel: ListViewModel = ListViewModel(), exchangeService: APIServiceProtocol = ApiService()) {
        self.exchangeService = exchangeService
        self.viewModel = viewModel
    }
    
    func refresh(_ state: Update){
        timer?.invalidate()
        
        if state == .start{
            update()
            timer = Timer.scheduledTimer(timeInterval: Default.refreshInterval, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        }
    }
    
    @objc func update(){
        viewModel.isLoading.value = true
        exchangeService.fetchRates(symbols: [], interval: 0){ [weak self] (rates, error) in
            self?.viewModel.isLoading.value = false
            
            if let errorMsg = error?.localizedDescription {
                self?.viewModel.message.value = errorMsg
            }else{
                self?.viewModel.exchangeData.value = rates
            }
        } 
    }
}
