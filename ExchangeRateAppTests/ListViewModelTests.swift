//
//  ListViewModelTests.swift
//  ExchangeRateAppTests
//
//  Created by AlexandruGanea on 06/06/2020.
//  Copyright © 2020 AlexandruGanea. All rights reserved.
//

import XCTest
@testable import ExchangeRateApp

class ListViewModelTests: XCTestCase {
    
    var sut: ListViewModel!
    var controller: ListController!
    var mockAPIService: MockApiService!
    
    override func setUp() {
        mockAPIService = MockApiService()
        controller = ListController.init(exchangeService: mockAPIService)
        sut = controller.viewModel
    }
    
    override func tearDown() {
        mockAPIService = nil
        controller = nil
    }
    
    func test_viewModel_load() {
        var loadingStatus = false
        
        let expect = XCTestExpectation(description: "Loading status updated")
        sut.isLoading.addObserver { [weak sut] (isLoading) in
            loadingStatus = sut!.isLoading.value
            
            if loadingStatus == true {
                expect.fulfill()
            }
        }
        XCTAssertFalse( loadingStatus )
        controller.update()
        
        wait(for: [expect], timeout: 1.0)
        XCTAssertTrue( loadingStatus )
    }
    
    func test_data(){
        let expect = XCTestExpectation(description: "Rate currencies")
        
        sut.exchangeData.addObserver {(rates) in
            if rates.count > 0 {
                expect.fulfill()
            }
        }
        
        let rateStub = DataDummy.rateStub
        mockAPIService.completeRates = rateStub
        controller.update()
        mockAPIService.fetchSuccess()
        
        wait(for: [expect], timeout: 5.0)
        
        let sections = rateStub.count
        let rateObj = rateStub[sections-1]
        
        XCTAssertTrue(sut.numberOfSections() == sections)
        XCTAssertTrue(sut.numberOfItems(sut.exchangeData.value.count-1) == rateObj.currencyArray.count)
    }
    
    func test_cell_view_model() {
        let currency = Currency(name: "RON", value: NSNumber(value: 1.25))
        
        let cellViewModel = ExchangeInfoModel(currency)
        let parts = cellViewModel.information?.components(separatedBy: " ")
        
        XCTAssertTrue(currency.name == parts?.first && currency.value == NSNumber.init( value: Double(parts!.last!)!))
    }
}


