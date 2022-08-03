//
//  CurrencyDetailViewModel.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 03/08/22.
//

import Foundation

protocol CurrencyDetailsViewModelOutput {
    var title: String { get }
    var symbol: String { get }
    var code: String { get }
}

protocol CurrencyDetailViewModelProtocol : CurrencyDetailsViewModelOutput{}

class CurrencyDetailViewModel : CurrencyDetailViewModelProtocol {
    
    let currency : Currency?
    let title: String
    let symbol: String
    let code: String
    init(currency: Currency) {
        self.currency = currency
        self.title = currency.currencyName
        self.code = currency.currencyCode
        self.symbol = currency.currencySymbol
    }
}
