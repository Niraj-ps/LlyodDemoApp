//
//  CurrencyRepository.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 25/07/22.
//

import Foundation

protocol CurrencyRepository {
    func fetchCurrencyList(completion: @escaping (Result<[Currency], Error>) -> Void)
}
