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

    let data : Data
    init(data : Data){
        self.data = data
    }
    
    func perform(request: RequestProtocol) -> Promise<Data> {
        
        .value(data)
    }
}
