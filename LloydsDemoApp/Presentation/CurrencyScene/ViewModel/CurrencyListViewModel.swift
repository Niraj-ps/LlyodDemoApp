//
//  CurrencyListViewModel.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 11/07/22.
//

import Foundation

protocol CurrencyListViewModelProtocol {
    func requestCurrencyAPI()
    func numberOfRows() -> Int
    func getCurrencyAt(index : Int) -> Currency
    func updateCurencyListUsingSearch(text : String)
}

class CurrencyListViewModel {
  
    private var currencyList = [Currency]()
    private let currencyUseCase : CurrencyUseCaseProtocol
    private var currencySearchList = [Currency]()
    var error: Error?
    weak var delegate : CurrencyViewProtocol?
    
    init(currencyUseCase : CurrencyUseCaseProtocol) {
        self.currencyUseCase = currencyUseCase
    }

    func searchCurrencyList(text : String) {
        if text.isEmpty {
            currencySearchList = currencyList
        }
        else{
            currencySearchList = currencyList.filter({ currency in
                currency.currencyName.lowercased().contains(text.lowercased())
            })
        }
        self.delegate?.updateItemData()
    }
}

extension CurrencyListViewModel : CurrencyListViewModelProtocol {
    
    func getCurrencyAt(index: Int) -> Currency {
        return self.currencySearchList[index]
    }
    
    func numberOfRows() -> Int {
        self.currencySearchList.count
    }
    
    func requestCurrencyAPI() {
        self.currencyUseCase.getCurrencyList { [weak self] result in
            switch result {
                case .success(let currencyData):
                    self?.currencyList = currencyData
                case .failure(let error):
                    self?.error = error
            }
            self?.searchCurrencyList(text: "")
        }
    }
    
    func updateCurencyListUsingSearch(text : String){
        self.searchCurrencyList(text: text)
    }
}
