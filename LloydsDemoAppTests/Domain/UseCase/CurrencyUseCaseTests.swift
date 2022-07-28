//
//  CurrencyUseCaseTests.swift
//  LloydsDemoAppTests
//
//  Created by Niraj Shah on 19/07/22.
//

import XCTest
@testable import LloydsDemoApp

class CurrencyUseCaseTests: XCTestCase {
    
    func testCurrencyUseCase_whenRepoSuccefullyReturnsDomainModel(){
        let expectation = self.expectation(description: "Currency List Fetched")
        let currencyRepo = CurrencyRepositoryMock(result: .success(CurrencyDTO.stub()))
        let usecase = CurrencyUseCase(currencyRepository: currencyRepo)
        var recents = [Currency]()
        usecase.getCurrencyList { result in
            switch result {
            case .success(let currencyData):
                recents = currencyData
                expectation.fulfill()
            case .failure(_):
                break
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(recents.count == 2)
    }
    
    func testCurrencyUseCase_whenRepoFailedToReturnDomainModel(){
        let expectation = self.expectation(description: "Currency List Not Fetched")
        let currencyRepo = CurrencyRepositoryMock(result: .failure(CurrencyFetchError.failedFetching))
        let usecase = CurrencyUseCase(currencyRepository: currencyRepo)
        var usecaseFailedError : Error?
        usecase.getCurrencyList { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                usecaseFailedError = error
                expectation.fulfill()
                break
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(usecaseFailedError != nil)
    }
}

enum CurrencyFetchError : Error {
    case failedFetching
}
