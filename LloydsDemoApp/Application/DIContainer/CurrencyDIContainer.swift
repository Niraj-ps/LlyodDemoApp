//
//  CurrencyDIContainer.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 18/07/22.
//

import Foundation

final class CurrencyDIContainer {

    func makeCurrencyUseCase() -> CurrencyUseCase {
        return DefaultCurrencyUseCase(currencyRepository: makeCurrencyRepository())
    }
    
    func makeCurrencyRepository() -> CurrencyRepository {
        return DefaultCurrencyRepository(currencyService: makeCurrencyService())
    }
    
    func makeCurrencyService() -> CurrencyService {
        
        return CurrencyService(networkServices: makeNetworkService())
    }
    
    func makeNetworkManager() -> NetworkManagerProtocol {
        return NetworkManager()
    }
    
    func makeNetworkService() -> NetworkAPIService {
        let config = NetworkConfiguration.init(baseURLPath: Constants.apiEndPoint)
        return NetworkAPIService(sessionManager: makeNetworkManager(), apiEndPoints: config)
    }
    
    func makeCurrencyListViewController() -> CurrencyListViewController {
        
        let currencyListViewController = CurrencyListViewController.create(with: makeCurrencyListViewModel())
        return currencyListViewController
    }
    
    func makeCurrencyListViewModel() -> CurrencyListViewModel{
        
        return CurrencyListViewModel(currencyUseCase: makeCurrencyUseCase())
    }
    
}
