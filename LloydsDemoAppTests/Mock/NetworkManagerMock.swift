//
//  NetworkManagerMock.swift
//  LloydsDemoAppTests
//
//  Created by Niraj Shah on 22/07/22.
//

@testable import LloydsDemoApp
import PromiseKit


struct NetworkManagerMock : NetworkManagerProtocol {
    
    var response : (Data?, Error?)
    func request (_ urlRequest: URLRequest) -> Promise<Data> {
        
            return Promise { seal in
                if response.1 == nil {
                    seal.fulfill(response.0!)
                }
                else{
                    seal.reject(response.1!)
                }
            }
        }
}
