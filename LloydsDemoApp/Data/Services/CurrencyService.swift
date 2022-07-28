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
    init(networkManager : NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}

extension CurrencyService : CurrencyServiceProtocol {
    
    func requestCurrencyList(completion : @escaping (Result<[CurrencyDTO], Error>) -> Void) {

        self.networkManager.request(endpoint: CurrencyEndpoint.currencyList, responseModel: CurrencyResponse.self).done { currencyResponse in
            let currencyData = currencyResponse.currencies
            completion(.success(currencyData))
        }
        .catch { error in
            completion(.failure(error))
        }
    }
}
