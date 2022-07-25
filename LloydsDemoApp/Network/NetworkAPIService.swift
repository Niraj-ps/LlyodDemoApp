//
//  NetworkAPIService.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 18/07/22.
//

import Foundation
import PromiseKit

protocol NetworkServices {
    
    func perform (request: RequestProtocol) -> Promise<Data>
}

class NetworkAPIService {
    
    let sessionManager : NetworkManagerProtocol
    let apiEndPoints : NetworkConfigProtocol
    init(sessionManager : NetworkManagerProtocol, apiEndPoints : NetworkConfigProtocol) {
        self.sessionManager = sessionManager
        self.apiEndPoints = apiEndPoints
    }
}

extension NetworkAPIService : NetworkServices {
    
    func perform (request: RequestProtocol) -> Promise<Data> {

        return Promise { seal in
            request.createURLRequest(endPoints: self.apiEndPoints).done { urlRequest in
                self.sessionManager.request(urlRequest).done { response in
                    seal.fulfill(response)
                }
                .catch { error in
                    seal.reject(error)
                }
            }
            .catch{ error in
                seal.reject(error)
            }
        }
    }
}
