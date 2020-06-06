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
    var dataProcess: DataProcess {get set}
    func fetchRates(symbols: [String], interval: Int, completionBlock: @escaping (_ rates: [Rate], _ error: Error? )->() )
}


class ApiService: APIServiceProtocol{
    
    static let base = "https://api.exchangeratesapi.io"
    var dataProcess: DataProcess = DataProcess()
    
    func fetchRates(symbols: [String], interval: Int, completionBlock: @escaping (_ rates: [Rate], _ error: Error? )->()) {
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
