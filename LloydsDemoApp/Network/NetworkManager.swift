//
//  NetworkManager.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 11/07/22.
//

import Foundation
import PromiseKit

protocol NetworkManagerProtocol {
    func request<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) -> Promise<T>
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
    
    func createURLRequest(endpoint : Endpoint) -> Promise<URLRequest> {
        return Promise<URLRequest> { seal in
            var urlComponents = URLComponents()
            urlComponents.scheme = endpoint.scheme
            urlComponents.host = endpoint.host
            urlComponents.path = endpoint.path
            guard let url = urlComponents.url else {
                return seal.reject(NetworkError.invalidURL)
            }
            let urlRequest = URLRequest(url: url)
            seal.fulfill(urlRequest)
        }
    }
}

extension NetworkManager : NetworkManagerProtocol  {
    
    func request<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) -> Promise<T> {
        return Promise { seal in
            firstly {
                createURLRequest(endpoint: endpoint)
            }
            .then{ urlRequest in
                URLSession.shared.dataTask(.promise, with: urlRequest).validate()
            }
            .map {
                try JSONDecoder().decode(responseModel, from: $0.data)
            }
            .done { result in
                seal.fulfill(result)
            }.catch { error in
                seal.reject(error)
            }
        }
    }
}
