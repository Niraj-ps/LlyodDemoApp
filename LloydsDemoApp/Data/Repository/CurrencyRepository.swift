//
//  Repository.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 12/07/22.
//

import Foundation

class CurrencyRepository {
    
    let currencyService : CurrencyServiceProtocol
    init(currencyService : CurrencyServiceProtocol) {
        self.currencyService = currencyService
    }
}

extension CurrencyRepository : CurrencyRepositoryProtocol {
    
    func fetchCurrencyList(completion: @escaping (Result<[Currency], Error>) -> Void) {
        self.currencyService.requestCurrencyList { result in
            switch result{
            case .success(let currencyDTO):
                completion(.success(currencyDTO.map{$0.toDomain()}))
            case .failure(let error):
                completion(.failure(error))
            }
         }
    }
}
