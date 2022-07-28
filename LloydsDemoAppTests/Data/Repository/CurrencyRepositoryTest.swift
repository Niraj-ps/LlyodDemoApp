//
//  CurrencyRepositoryTest.swift
//  LloydsDemoAppTests
//
//  Created by Niraj Shah on 19/07/22.
//

import XCTest
@testable import LloydsDemoApp

class CurrencyRepositoryTest: XCTestCase {
    
    func testCurrencyRepository_whenServiceReturnsDataModel() {
        
        let expectation = self.expectation(description: "Fetched Currency Data Model")
        let currencyServiceMock = CurrencyServiceProtocolMock(result: .success(CurrencyDTO.stub()))
        let repository = CurrencyRepository(currencyService: currencyServiceMock)
        var recents = [Currency]()
        repository.fetchCurrencyList { result in
            switch result {
            case .success(let currencyData):
                recents = currencyData
                expectation.fulfill()
            case .failure(_):
                break
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(recents.count > 0)
    }
    
    func testCurrencyRepository_whenServiceReturnsError() {
        
        let expectation = self.expectation(description: "Fetched Currency Data Model")
        let currencyServiceMock = CurrencyServiceProtocolMock(result: .failure(CurrencyFetchError.failedFetching))
        let repository = CurrencyRepository(currencyService: currencyServiceMock)
        var recents = [Currency]()
        repository.fetchCurrencyList { result in
            switch result {
            case .success(let currencyData):
                recents = currencyData
            case .failure(_):
                expectation.fulfill()
                break
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(recents.count, 0)
    }
}
