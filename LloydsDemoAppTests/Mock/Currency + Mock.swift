//
//  Currency + Mock.swift
//  LloydsDemoAppTests
//
//  Created by Niraj Shah on 22/07/22.
//

import Foundation
@testable import LloydsDemoApp

extension Currency {
    
    static func stub() -> [Self] {
        let eCurrency = self.init(currencySymbol: "€", currencyName: "Euro", currencyCode: "EUR")
        let iCurrency = self.init(currencySymbol: "₹", currencyName: "Indian Rupee", currencyCode: "INR")
        return [eCurrency, iCurrency]
    }
}
