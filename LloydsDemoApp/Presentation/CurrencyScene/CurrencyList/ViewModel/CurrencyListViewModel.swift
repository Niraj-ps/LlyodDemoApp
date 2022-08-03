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
    func didSelectItem(at : Int)
}

class CurrencyListViewModel {
  
    private var currencyList = [Currency]()
    private let currencyUseCase : CurrencyUseCaseProtocol
    private var currencySearchList = [Currency]()
    weak var delegate : CurrencyViewProtocol?
    private let actions: CurrencyListViewModelActions?
    var error: Error?

    init(currencyUseCase : CurrencyUseCaseProtocol, actions : CurrencyListViewModelActions? = nil) {
        self.currencyUseCase = currencyUseCase
        self.actions = actions
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
    
    func didSelectItem(at index : Int) {
       let currency = self.getCurrencyAt(index: index)
        actions?.showCurrencyDetails(currency)
    }
}

struct CurrencyListViewModelActions {
    let showCurrencyDetails: (Currency) -> Void
}
