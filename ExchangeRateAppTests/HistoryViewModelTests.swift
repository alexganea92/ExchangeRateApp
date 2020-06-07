//
//  HistoryViewModelTests.swift
//  ExchangeRateAppTests
//
//  Created by AlexandruGanea on 06/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import XCTest
import Charts
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
    
    func test_max_y(){
        var charDataEntries = [ChartDataEntry]()
        let number = 25
        for i in 1...number{
            charDataEntries.append(ChartDataEntry(x: 0, y: Double(i)))
        }
        
        let set = LineChartDataSet(entries: charDataEntries, label: "Test Data")
        let chartData = LineChartData(dataSet: set)
        
        let max = sut.roundUp(chartData)
        XCTAssertTrue(max == Double(number))
    }
}
