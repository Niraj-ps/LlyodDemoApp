//
//  CurrencyRepositoryMock.swift
//  LloydsDemoAppTests
//
//  Created by Niraj Shah on 22/07/22.
//

import Foundation
@testable import LloydsDemoApp

struct CurrencyRepositoryMock : CurrencyRepositoryProtocol {
    
    var result: Result<[CurrencyDTO], Error>

    func fetchCurrencyList(completion: @escaping (Result<[Currency], Error>) -> Void) {
            
        switch result {
        case .success(let currencyDTO):
            completion(.success(currencyDTO.map{$0.toDomain()}))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
