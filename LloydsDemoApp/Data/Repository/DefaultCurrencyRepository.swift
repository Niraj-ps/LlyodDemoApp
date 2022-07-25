//
//  Repository.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 12/07/22.
//

import Foundation

class DefaultCurrencyRepository {
    
    let currencyService : CurrencyServiceProtocol
    
    init(currencyService : CurrencyServiceProtocol) {
        self.currencyService = currencyService
    }
}

extension DefaultCurrencyRepository : CurrencyRepository {
    
    func fetchCurrencyList(completion: @escaping (Result<[Currency], Error>) -> Void) {

        let apiEndPints = APIEndpoints(path: Constants.currencyPath)
        self.currencyService.request(endpoints: apiEndPints) { (result : Result<CurrencyResponse, NetworkError>) in
            switch result {
            case .success(let response):
                    let currencyData = response.decodedCurrency.map{$0.toDomain()}
                    completion(.success(currencyData))
                
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
