//
//  NetworkManager.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 11/07/22.
//

import Foundation
import PromiseKit

protocol NetworkManagerProtocol {
    func request (_ urlRequest: URLRequest) -> Promise<Data>
}

public enum NetworkError: Error, Equatable {
    case invalidURL
    case noInternet
    case noResponse
    case parseFailed
    case someError
}

class NetworkManager {
    let urlSession : URLSession
    init(urlSession : URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
}

extension NetworkManager : NetworkManagerProtocol  {
    
    func request (_ urlRequest: URLRequest) -> Promise<Data> {
        
        return Promise { seal in
            
            firstly {
                URLSession.shared.dataTask(.promise, with: urlRequest).validate()
            }
            .map {
                $0.data
            }
            .done { result in
                seal.fulfill(result)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
}
