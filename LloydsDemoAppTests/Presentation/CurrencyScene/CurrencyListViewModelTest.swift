//
//  CurrencyListViewModelTest.swift
//  LloydsDemoAppTests
//
//  Created by Niraj Shah on 19/07/22.
//

import XCTest
@testable import LloydsDemoApp

class CurrencyListViewModelTest: XCTestCase {
    
    private enum CurrencyError: Error {
        case someError
    }
    
    func test_whenCurrencyUseCaseRetrievesList_thenViewModelContainsData() {
       
        var currencyUseCase = CurrencyUseCaseMock(result: .success(Currency.stub()))
        currencyUseCase.expectation = self.expectation(description: "contains same no of data")
        let viewModel = CurrencyListViewModel(currencyUseCase: currencyUseCase)
        viewModel.requestAPIData(currencyViewDelegate: CurrencyViewModelProtocolMock())
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.searchItems.count, 2)
    }

    
    func test_whenCurrencyUseCaseReturnsError_thenViewModelContainsError() {
        
        var currencyUseCase = CurrencyUseCaseMock(result: .failure(CurrencyError.someError))
        currencyUseCase.expectation = self.expectation(description: "contain errors")
        let viewModel = CurrencyListViewModel(currencyUseCase: currencyUseCase)
        viewModel.requestAPIData(currencyViewDelegate: CurrencyViewModelProtocolMock())
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(viewModel.error)
    }
    
    func test_SearchTextAvailableInViewModelData() {
       
        var currencyUseCase = CurrencyUseCaseMock(result: .success(Currency.stub()))
        currencyUseCase.expectation = self.expectation(description: "contains search text in list")
        let viewModel = CurrencyListViewModel(currencyUseCase: currencyUseCase)
        viewModel.requestAPIData(currencyViewDelegate: CurrencyViewModelProtocolMock())
        waitForExpectations(timeout: 5, handler: nil)
        viewModel.searchCurrencyList(text: "Euro")
        XCTAssertEqual(viewModel.searchItems.count, 1)
    }
    
}
