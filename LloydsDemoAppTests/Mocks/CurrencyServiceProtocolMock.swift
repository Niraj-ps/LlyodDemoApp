//
//  CurrencyServiceProtocolMock.swift
//  LloydsDemoAppTests
//
//  Created by Niraj Shah on 24/07/22.
//

import Foundation
@testable import LloydsDemoApp

class CurrencyServiceProtocolMock : CurrencyServiceProtocol {
    
    var fileName : String
    init(fileName : String) {
        self.fileName = fileName
    }
    
    func requestCurrencyList(completion: @escaping (Result<[CurrencyDTO], Error>) -> Void) {
        
        let testBundle = Bundle(for: type(of: self))
        if let url = testBundle.url(forResource: fileName, withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(CurrencyResponse.self, from: data)
                    completion(.success(jsonData.currencies))
                } catch {
                    completion(.failure(NetworkError.parseFailed))
                }
            }
            else{
                completion(.failure(NetworkError.invalidURL))
            }
        }
}

