//
//  DataDummy.swift
//  ExchangeRateAppTests
//
//  Created by AlexandruGanea on 06/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import Foundation
@testable import ExchangeRateApp

class DataDummy{
    
    /**
      Provides data sample
    */
    static var rateStub: [Rate] = {
        var ratesArray: [Rate] = []
        if let path = Bundle.main.path(forResource: "latestRateResponseSample", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                let dataDictionary = json as? Dictionary<String, Any>
                ratesArray = DataProcess.init().currentRate(dataDictionary!)
            } catch {
            }
        }
        return ratesArray
    }()
    
    /**
      Provides data interval sample
    */
    static var rateIntervalStub: [Rate] = {
        var ratesArray: [Rate] = []
        if let path = Bundle.main.path(forResource: "historyRateSample", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                let dataDictionary = json as? Dictionary<String, Any>
                ratesArray = DataProcess.init().historyRate(dataDictionary!)
            } catch {
            }
        }
        return ratesArray
    }()
}
