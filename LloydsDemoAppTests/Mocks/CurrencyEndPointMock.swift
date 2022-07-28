//
//  CurrencyEndPointMock.swift
//  LloydsDemoAppTests
//
//  Created by Niraj Shah on 28/07/22.
//

import Foundation
@testable import LloydsDemoApp

enum CurrencyEndPointMock {
    case currencyJSON
    case currencyInvalidJSON
}

extension CurrencyEndPointMock : Endpoint {
    
    var path: String {
        switch self {
            case .currencyJSON:
                return "CurrencyListJson"
            case .currencyInvalidJSON:
                return "CurrencyInvalidJson"
        }
    }
}
