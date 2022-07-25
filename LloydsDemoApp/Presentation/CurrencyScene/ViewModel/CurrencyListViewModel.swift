//
//  CurrencyListViewModel.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 11/07/22.
//

import Foundation

class CurrencyListViewModel {
  
    var itemLists = [Currency]()
    var currencyUseCase : CurrencyUseCase
    var searchItems = [Currency]()
    var error: Error?
    var delegate : CurrencyViewProtocol?
    
    init(currencyUseCase : CurrencyUseCase) {
        self.currencyUseCase = currencyUseCase
    }

    func requestAPIData(currencyViewDelegate : CurrencyViewProtocol) {
        
        self.delegate = currencyViewDelegate
        self.currencyUseCase.getCurrencyList { [weak self] result in
            
            switch result {
                case .success(let currencyData):
                    self?.itemLists = currencyData
                case .failure(let error):
                    self?.error = error
            }
            self?.searchCurrencyList(text: "")
        }
    }

    func searchCurrencyList(text : String) {
        
        if text.isEmpty {
            searchItems = itemLists
        }
        else{
            searchItems = itemLists.filter({ currency in
                currency.currencyName.lowercased().contains(text.lowercased())
            })
        }
        self.delegate?.updateItemData()
    }
}
