//
//  CurrencyDetailViewModelTest.swift
//  LloydsDemoAppTests
//
//  Created by Niraj Shah on 03/08/22.
//

import XCTest
@testable import LloydsDemoApp

class CurrencyDetailViewModelTest: XCTestCase {

    func test_CurrencyTitle() {
        let viewModel = CurrencyDetailViewModel(currency: Currency.stub().first!)
        XCTAssertEqual(viewModel.title, "Euro")
    }
    
    func test_CurrencySymbol() {
        let viewModel = CurrencyDetailViewModel(currency: Currency.stub().first!)
        XCTAssertEqual(viewModel.symbol, "€")
    }
    
    func test_CurrencyCode() {
        let viewModel = CurrencyDetailViewModel(currency: Currency.stub().first!)
        XCTAssertEqual(viewModel.code, "EUR")
    }
}
 
