//
//  RequestProtocol.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 24/07/22.
//

import Foundation
import PromiseKit

enum RequestType: String {
  case GET
  case POST
}

protocol RequestProtocol {

    var path: String { get }

    func createURLRequest(endPoints : NetworkConfigProtocol) -> Promise<URLRequest>
}

extension RequestProtocol {
    
    func createURLRequest(endPoints : NetworkConfigProtocol) -> Promise<URLRequest> {
        
        return Promise<URLRequest> { seal in
            
            let apiPath = endPoints.baseURLPath.appending(path)
            guard let url = URL.init(string: apiPath) else {
               return seal.reject(NetworkError.invalidURL)
            }
            let urlRequest = URLRequest.init(url: url)
            seal.fulfill(urlRequest)
        }
    }
}
