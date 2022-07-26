//
//  NetworkAPIServiceMock.swift
//  LloydsDemoAppTests
//
//  Created by Niraj Shah on 22/07/22.
//

import Foundation
@testable import LloydsDemoApp
import PromiseKit

class NetworkAPIServiceMock : NetworkServices {

    let data : Data?
    let error : Error?
    init(data : Data?, error : Error?){
        self.data = data
        self.error = error
    }
    
    func perform(request: RequestProtocol) -> Promise<Data> {
        
        return Promise { seal in
            
            if data != nil {
                seal.fulfill(data!)
            }
            else{
                seal.reject(NetworkError.someError)
            }
        }
    }
}
