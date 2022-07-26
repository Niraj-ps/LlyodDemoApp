//
//  CurrencyRepositoryMock.swift
//  LloydsDemoAppTests
//
//  Created by Niraj Shah on 22/07/22.
//

import Foundation
@testable import LloydsDemoApp

struct CurrencyRepositoryMock : CurrencyRepository {
    
    var result: Result<[Currency], Error>

    func fetchCurrencyList(completion: @escaping (Result<[Currency], Error>) -> Void) {
        completion(result)
    }
}
