//
//  CurrencyService.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 24/07/22.
//

import Foundation

protocol CurrencyServiceProtocol {
    func request <T : Decodable> (endpoints : RequestProtocol, completion : @escaping (Result< T, NetworkError>) -> Void)
}

class CurrencyService {
    
    var networkServices : NetworkServices
    init(networkServices : NetworkServices) {
        self.networkServices = networkServices
    }
    
}

extension CurrencyService : CurrencyServiceProtocol {
    
    func request <T : Decodable> (endpoints : RequestProtocol, completion : @escaping (Result<T, NetworkError>) -> Void) {
        
        self.networkServices.perform(request: endpoints).done { data in
            let result: Result<T, NetworkError> = self.decode(data: data)
            completion(result)
        }
        .catch { error in
            completion(.failure(error as! NetworkError))
        }
    }
    
    private func decode<T: Decodable>(data: Data) -> Result<T, NetworkError> {
        do {
            let result: T = try JSONDecoder().decode(T.self, from: data)
            return .success(result)
        } catch {
            return .failure(.parseFailed)
        }
    }
}
