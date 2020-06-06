//
//  MockApiService.swift
//  ExchangeRateAppTests
//
//  Created by AlexandruGanea on 06/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import Foundation
@testable import ExchangeRateApp

class MockApiService: APIServiceProtocol {
    var dataProcess: DataProcess = DataProcess()
    
    var completeRates: [Rate] = [Rate]()
    var completeClosure: (([Rate], Error?) -> ())!
    
    func fetchRates(symbols: [String], interval: Int, completionBlock: @escaping (_ rates: [Rate], _ error: Error? )->() ) {
        completeClosure = completionBlock
    }
    
    func fetchSuccess() {
        completeClosure(completeRates, nil )
    }
}
