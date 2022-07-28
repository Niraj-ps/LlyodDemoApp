//
//  CurrencyService.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 24/07/22.
//

import Foundation

protocol CurrencyServiceProtocol {
    func requestCurrencyList(completion : @escaping (Result<[CurrencyDTO], Error>) -> Void)
}

class CurrencyService {
    
    let networkManager : NetworkManagerProtocol
    let currencyEndpoint : CurrencyEndpoint
    init(networkManager : NetworkManagerProtocol, currencyEndpoint : CurrencyEndpoint) {
        self.networkManager = networkManager
        self.currencyEndpoint = currencyEndpoint
    }
}

extension CurrencyService : CurrencyServiceProtocol {
    
    func requestCurrencyList(completion : @escaping (Result<[CurrencyDTO], Error>) -> Void) {
        self.networkManager.request(endpoint: self.currencyEndpoint, responseModel: CurrencyResponse.self).done { currencyResponse in
            let currencyData = currencyResponse.currencies
            completion(.success(currencyData))
        }
        .catch { error in
            completion(.failure(error))
        }
    }
}
