//
//  CurrencyServiceProtocolMock.swift
//  LloydsDemoAppTests
//
//  Created by Niraj Shah on 24/07/22.
//

import Foundation
@testable import LloydsDemoApp

struct CurrencyServiceProtocolMock : CurrencyServiceProtocol {
    
    var result: Result<[CurrencyDTO], Error>
    func requestCurrencyList(completion: @escaping (Result<[CurrencyDTO], Error>) -> Void) {
        
        switch result {
        case .success(let currencyDTO):
            completion(.success(currencyDTO))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}

