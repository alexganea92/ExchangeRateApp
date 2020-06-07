//
//  ListViewModel.swift
//  ExchangeRateApp
//
//  Created by AlexandruGanea on 02/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import Foundation

class ListViewModel: ViewModel{
    var isLoading = Observable<Bool>(value: false)
    var exchangeData = Observable<[Rate]>(value: [])
    var message = Observable<String?>(value: nil)
    
   
    /**
     Gets the section number
     
     - returns:
     Section number
     
     */
    func numberOfSections() -> Int {
        return exchangeData.value.count
    }
    
    /**
     Gets the number of items
     
     - returns:
     The number of items
     
     - parameters:
        - section: requested section
     */
    func numberOfItems(_ section: Int) -> Int{
        let data = exchangeData.value[section]
        return data.currencyArray.count
    }
    
    /**
     Gets the cell's view model
     
     - returns:
     view model object
     
     - parameters:
        - idxP: requested indexPath
     */
    func objectFor(_ idxP: IndexPath) -> ExchangeInfoModel{
        let data = exchangeData.value[idxP.section]
        return ExchangeInfoModel.init(data.currencyArray[idxP.row])
    }
    
    /**
      Gets the title of the rate
      
      - returns:
      A formatted string
      */
    func title() -> String{
        guard self.exchangeData.value.count > 0 else {
            return ""
        }
        let obj = exchangeData.value[exchangeData.value.count-1]
        return String(obj.base + " " + obj.date)
    }
}
