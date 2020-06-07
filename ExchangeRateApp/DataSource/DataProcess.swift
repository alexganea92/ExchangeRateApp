//
//  DataProcess.swift
//  ExchangeRateApp
//
//  Created by AlexandruGanea on 06/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import Foundation

class DataProcess{
    
    /**
     Get the current rates as formatted data
     */
    
    let currentRate: (Dictionary<String, Any>) -> [Rate] = { (dataDictionary) in
        var ratesArray: [Rate] = []
        let rateObj = Rate.init(date: dataDictionary["date"] as! String, base: dataDictionary["base"] as! String, rates: dataDictionary["rates"] as! [String : NSNumber])
        ratesArray.append(rateObj)
        
        return ratesArray
    }
    
    /**
    Get the current history rates as formatted data
    */
    
    let historyRate: (Dictionary<String, Any>) -> [Rate] = { (dataDictionary) in
        var ratesArray: [Rate] = []
        let dictionaries = dataDictionary["rates"] as! [String : [String:NSNumber]]
        for (key, value) in dictionaries {
            let rateObj = Rate.init(date: key , base: "", rates: value)
            ratesArray.append(rateObj)
        }
        return ratesArray
    }
}
