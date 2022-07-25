//
//  CurrencyDTO.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 19/07/22.
//

import Foundation

struct CurrencyDTO : Codable {
    
    var currencySymbol: String
    var currencyName: String
    var currencyCode: String
}

extension CurrencyDTO {
  
   func toDomain() -> Currency {
    
      return Currency(currencySymbol: currencySymbol, currencyName: currencyName, currencyCode: currencyCode)
  }
}
