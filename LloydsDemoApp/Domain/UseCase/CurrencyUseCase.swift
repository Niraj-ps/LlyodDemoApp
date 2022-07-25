//
//  CurrencyUseCase.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 12/07/22.
//

import Foundation

protocol CurrencyUseCase{
    func getCurrencyList(completion: @escaping (Result<[Currency], Error>) -> Void)
}

class DefaultCurrencyUseCase  {
   
    let currencyRepository : CurrencyRepository
    init(currencyRepository : CurrencyRepository){
        self.currencyRepository = currencyRepository
    }
}

extension DefaultCurrencyUseCase : CurrencyUseCase {
    
    func getCurrencyList(completion: @escaping (Result<[Currency], Error>) -> Void) {
        self.currencyRepository.fetchCurrencyList { result in
           completion(result)
        }
    }
}
