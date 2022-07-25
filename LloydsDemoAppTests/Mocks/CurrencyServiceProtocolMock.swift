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
    
    func request<T>(endpoints: RequestProtocol, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        
        let testBundle = Bundle(for: type(of: self))
        if let url = testBundle.url(forResource: fileName, withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(T.self, from: data)
                    completion(.success(jsonData))
                } catch {
                    completion(.failure(.noResponse))
                }
            }
            else{
                completion(.failure(.invalidURL))
            }
        }
}
