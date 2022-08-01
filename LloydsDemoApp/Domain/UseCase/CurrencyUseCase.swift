//
//  CurrencyUseCase.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 12/07/22.
//

import Foundation

protocol CurrencyUseCaseProtocol{
    func getCurrencyList(completion: @escaping (Result<[Currency], Error>) -> Void)
}

class CurrencyUseCase  {
   
    let currencyRepository : CurrencyRepositoryProtocol
    init(currencyRepository : CurrencyRepositoryProtocol){
        self.currencyRepository = currencyRepository
    }
}

extension CurrencyUseCase : CurrencyUseCaseProtocol {
    
    func getCurrencyList(completion: @escaping (Result<[Currency], Error>) -> Void) {
        self.currencyRepository.fetchCurrencyList { result in
           completion(result)
        }
    }
}
