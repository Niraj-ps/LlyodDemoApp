//
//  CurrencyEndpoint.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 24/07/22.
//

import Foundation

enum CurrencyEndpoint {
    case currencyList
}

extension CurrencyEndpoint: Endpoint {
    var path: String {
        switch self {
        case .currencyList:
            return Constants.currencyPath
        }
    }
}
