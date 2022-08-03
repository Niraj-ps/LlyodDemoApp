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
    
    func test_whenCurrencyUseCaseRetrievesList_thenViewModelShouldHaveData() {
        var currencyUseCase = CurrencyUseCaseMock(result: .success(Currency.stub()))
        currencyUseCase.expectation = self.expectation(description: "contains data")
        let viewModel = CurrencyListViewModel(currencyUseCase: currencyUseCase)
        viewModel.requestCurrencyAPI()
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.numberOfRows(), 2)
    }
    
    func test_whenCurrencyUseCaseReturnsError_thenViewModelContainsError() {
        var currencyUseCase = CurrencyUseCaseMock(result: .failure(CurrencyError.someError))
        currencyUseCase.expectation = self.expectation(description: "contain errors")
        let viewModel = CurrencyListViewModel(currencyUseCase: currencyUseCase)
        viewModel.requestCurrencyAPI()
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(viewModel.error)
    }
    
    func test_SearchTextAvailableInViewModelData() {
        var currencyUseCase = CurrencyUseCaseMock(result: .success(Currency.stub()))
        currencyUseCase.expectation = self.expectation(description: "contains search text in list")
        let viewModel = CurrencyListViewModel(currencyUseCase: currencyUseCase)
        viewModel.requestCurrencyAPI()
        waitForExpectations(timeout: 5, handler: nil)
        viewModel.searchCurrencyList(text: "Euro")
        let currency = viewModel.getCurrencyAt(index: 0)
        XCTAssertEqual(currency.currencyName, "Euro")
    }
    
}
