//
//  HistoryViewModelTests.swift
//  ExchangeRateAppTests
//
//  Created by AlexandruGanea on 06/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import XCTest
@testable import ExchangeRateApp

class HistoryViewModelTests: XCTestCase {
    
    var sut: HistoryViewModel!
    var controller: HistoryController!
    var mockAPIService: MockApiService!
    
    override func setUp() {
        mockAPIService = MockApiService()
        controller = HistoryController.init(exchangeService: mockAPIService)
        sut = controller.viewModel
    }
    
    override func tearDown() {
        mockAPIService = nil
        controller = nil
    }
    
    func test_data() {
        let expect = XCTestExpectation(description: "Rate history")
        sut.exchangeDataArray.addObserver {(rates) in
            if rates.count > 0 {
                expect.fulfill()
            }
        }
        
        let rates = DataDummy.rateIntervalStub
        mockAPIService.completeRates = rates
        controller.update()
        mockAPIService.fetchSuccess()
        
        let currencies = rates.count
        wait(for: [expect], timeout: 1)
        XCTAssertTrue(sut.exchangeDataArray.value.count == currencies)
    }
}
