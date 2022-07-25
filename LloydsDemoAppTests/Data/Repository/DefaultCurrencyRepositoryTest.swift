//
//  DefaultCurrencyRepositoryTest.swift
//  LloydsDemoAppTests
//
//  Created by Niraj Shah on 19/07/22.
//

import XCTest
@testable import LloydsDemoApp
import PromiseKit

class DefaultCurrencyRepositoryTest: XCTestCase {
    
    
    func testCurrencyRepository_whenSuccessfullyFetchesCurrencyList(){
        
        let expectation = self.expectation(description: "Fetched Currency repo List")
        let currencyServiceMock = CurrencyServiceProtocolMock(fileName: "CurrencyListJson")
        let repository = DefaultCurrencyRepository(currencyService: currencyServiceMock)
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
    
    func testCurrencyRepository_whenInvalidURL(){
        
        let expectation = self.expectation(description: "Currency List Not Fetched")
        let currencyServiceMock = CurrencyServiceProtocolMock(fileName: "4jk./jik")
        let repository = DefaultCurrencyRepository(currencyService: currencyServiceMock)
        var invalidURLError : Error?
        repository.fetchCurrencyList { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                invalidURLError = error
                expectation.fulfill()
                break
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(invalidURLError != nil)
    }
    
    func testCurrencyRepository_whenInvalidJSON() {
        
        let expectation = self.expectation(description: "Currency List Not Fetched")
        let currencyServiceMock = CurrencyServiceProtocolMock(fileName: "CurrencyInvalidJson")
        let repository = DefaultCurrencyRepository(currencyService: currencyServiceMock)
        var invalidJSONError : Error?
        repository.fetchCurrencyList { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                invalidJSONError = error
                expectation.fulfill()
                break
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(invalidJSONError != nil)
    }
    
}
