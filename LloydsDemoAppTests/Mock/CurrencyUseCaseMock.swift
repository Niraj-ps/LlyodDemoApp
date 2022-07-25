//
//  CurrencyUseCaseMock.swift
//  LloydsDemoAppTests
//
//  Created by Niraj Shah on 22/07/22.
//

import XCTest
@testable import LloydsDemoApp

struct CurrencyUseCaseMock: CurrencyUseCase {
    
    var result: Result<[Currency], Error>
    var expectation : XCTestExpectation?

    func getCurrencyList(completion: @escaping (Result<[Currency], Error>) -> Void) {
        completion(result)
        expectation?.fulfill()
    }
}
