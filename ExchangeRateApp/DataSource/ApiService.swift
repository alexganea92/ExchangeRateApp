//
//  ApiService.swift
//  ExchangeRateApp
//
//  Created by AlexandruGanea on 02/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import Foundation
import Alamofire

protocol APIServiceProtocol {
    /**
     Get formatted data
     */
    var dataProcess: DataProcess {get set}
    
    /**
     Get currency data
     
     - returns:
     Result of exchange API call
     
     - parameters:
        - symbols: wanted currencies
        - interval: days past current date
        - completionBlock:
        - rates: array of Rate objects
        - error: network error
     */
    func fetchRates(symbols: [String], interval: Int, completionBlock: @escaping (_ rates: [Rate], _ error: Error? )->() )
}


class ApiService: APIServiceProtocol{
    
    static let base = "https://api.exchangeratesapi.io"
    var dataProcess: DataProcess = DataProcess()
    
    func fetchRates(symbols: [String], interval: Int, completionBlock: @escaping (_ rates: [Rate], _ error: Error? )->()) {
        var request: String = ApiService.base
        
        if interval == 0 {
            request.append("/latest?base=" + Default.currencyBase)
        }else{
            let beforeDate =  Calendar.current.date(byAdding: .day, value: interval, to: Date())
            let now = Helper.sharedInstance.dateFormatter.string(from: Date())
            let before = Helper.sharedInstance.dateFormatter.string(from: beforeDate!)
            request.append("/history?start_at=" + before + "&end_at=" + now)
            
            for (idx, element) in symbols.enumerated() {
                if idx == symbols.startIndex {
                    request.append("&symbols=")
                }
                
                request.append(element)
                if idx != symbols.endIndex-1 {
                    request.append(",")
                }
            }
        }
        
        AF.request(request).response { response in
            var ratesArray = [Rate]()
            
            switch response.result {
            case let .success(value):
                
                let json = try? JSONSerialization.jsonObject(with: value!, options: [])
                guard let dataDictionary = json as? Dictionary<String, Any> else{
                    return
                }
                
                if interval < 0 {
                    ratesArray = self.dataProcess.historyRate(dataDictionary)
                }else{
                    ratesArray = self.dataProcess.currentRate(dataDictionary)
                }
                
                completionBlock(ratesArray, nil)
                
            case let .failure(error):
                completionBlock(ratesArray, error)
            }
        }
    }
    
}
