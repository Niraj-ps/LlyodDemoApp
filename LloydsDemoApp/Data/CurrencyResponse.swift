//
//  CurrencyResponse.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 19/07/22.
//

import Foundation

struct CurrencyResponse : Codable {
   
    struct CurrencyKey : CodingKey {
        var stringValue: String
        init(stringValue: String) {
            self.stringValue = stringValue
        }
        var intValue: Int? { return nil }
        init?(intValue: Int) { return nil }

        static let currencySymbol = CurrencyKey(stringValue: "symbol")
        static let currencyName  = CurrencyKey(stringValue: "name")
    }
    
    var decodedCurrency: [CurrencyDTO] = []

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CurrencyKey.self)

        for key in container.allKeys {
            let nested = try container.nestedContainer(keyedBy: CurrencyKey.self, forKey: key)
            let currencySymbol = try nested.decode(String.self, forKey: .currencySymbol)
            let currencyName = try nested.decode(String.self, forKey: .currencyName)
            let currencyDTO = CurrencyDTO(currencySymbol: currencySymbol, currencyName: currencyName, currencyCode: key.stringValue)
            decodedCurrency.append(currencyDTO)
        }
    }
}
