//
//  ListViewModel.swift
//  ExchangeRateApp
//
//  Created by AlexandruGanea on 02/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import Foundation

class ListViewModel{
    let isLoading = Observable<Bool>(value: false)
    let exchangeData = Observable<[Rate]>(value: [])
    
       // MARK: - Data source
    
    func numberOfSections() -> Int {
        return exchangeData.value.count
    }
    
    func numberOfItems(_ section: Int) -> Int{
        let data = exchangeData.value[section]
        return data.currencyArray.count
    }
    
    func objectFor(_ idxP: IndexPath) -> ExchangeInfoModel{
        let data = exchangeData.value[idxP.section]
        return ExchangeInfoModel.init(data.currencyArray[idxP.row])
    }
    
    func title() -> String{
        guard self.exchangeData.value.count > 0 else {
            return ""
        }
        let obj = exchangeData.value[exchangeData.value.count-1]
        return String(obj.base + " " + obj.date)
    }
}
