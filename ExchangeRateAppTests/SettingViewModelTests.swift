//
//  SettingViewModelTests.swift
//  ExchangeRateAppTests
//
//  Created by AlexandruGanea on 06/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import XCTest
@testable import ExchangeRateApp

class SettingViewModelTests: XCTestCase {
    
    var sut: SettingViewModel!
       var mockAPIService: MockApiService!

     override func setUp() {
         mockAPIService = MockApiService()
         sut = SettingViewModel()
     }
     
     override func tearDown() {
         mockAPIService = nil
         sut = nil
     }

    func test_currencies_options() {
        if let rateStub = DataDummy.rateStub.first{
            sut.setCurrencyNames(exchangeData: rateStub)
            XCTAssertTrue(sut.currencyOptions.count == rateStub.currencyArray.count)
        }
    }
    
    func test_currency_model(){
        let currency = Currency.init(name: "RON", value: NSNumber(value: 1.24))
        let currencyModel = CurrencyViewModel.init(currency)
        XCTAssertTrue(currency.name == currencyModel.name)
    }

}
