//
//  ApiService.swift
//  ExchangeRateApp
//
//  Created by AlexandruGanea on 02/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import Foundation
import Alamofire


class ApiService{
    
    static let base = "https://api.exchangeratesapi.io"
    
    func fetchRates(symbols: [String], interval: Int, completionBlock: @escaping (([Rate])->Void)){
        var request: String
        
        if interval == 0 {
            request = ApiService.base + "/latest" + "?base=" + Default.currencyBase
        }else{
            let beforeDate =  Calendar.current.date(byAdding: .day, value: interval, to: Date())
            let now = Helper.sharedInstance.dateFormatter.string(from: Date())
            let before = Helper.sharedInstance.dateFormatter.string(from: beforeDate!)
            var url = ApiService.base + "/history?start_at=" + before + "&end_at=" + now
            
            for (idx, element) in symbols.enumerated() {
                if idx == symbols.startIndex {
                    url = url + "&symbols="
                }

                url = url + element
                if idx != symbols.endIndex-1 {
                    url = url + ","
                }
            }
            
            request = url
        }
        
        print(request)
        
        AF.request(request).response { response in
            
            switch response.result {
            case let .success(value):
                
                let json = try? JSONSerialization.jsonObject(with: value!, options: [])
                guard let dataDictionary = json as? Dictionary<String, Any> else{
                    return
                }
                
                var ratesArray: [Rate] = []
                
                if interval < 0 {
                    let dictionaries = dataDictionary["rates"] as! [String : [String:NSNumber]]
                    for (key, value) in dictionaries {
                        let rateObj = Rate.init(date: key , base: "", rates: value)
                        ratesArray.append(rateObj)
                    }
                }else{
                    let rateObj = Rate.init(date: dataDictionary["date"] as! String, base: dataDictionary["base"] as! String, rates: dataDictionary["rates"] as! [String : NSNumber])
                    ratesArray.append(rateObj)
                }
                
                completionBlock(ratesArray)
                
            case let .failure(error):
                print(error)
            }
        }
    }
    
}
