//
//  CurrencyDIContainer.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 18/07/22.
//

import Foundation

final class CurrencyDIContainer {

    static var mainStoryBoard = LloydsMainStoryboard()

   private func makeCurrencyUseCase() -> CurrencyUseCaseProtocol {
        return CurrencyUseCase(currencyRepository: makeCurrencyRepository())
    }
    
    private func makeCurrencyRepository() -> CurrencyRepositoryProtocol {
        return CurrencyRepository(currencyService: makeCurrencyService())
    }
    
    private func makeCurrencyService() -> CurrencyService {
        let apiEndPoints = CurrencyEndpoint(path: Constants.currencyPath)
        return CurrencyService(networkManager: makeNetworkManager(), currencyEndpoint: apiEndPoints)
    }
    
    private func makeNetworkManager() -> NetworkManagerProtocol {
        return NetworkManager()
    }
    
     func makeCurrencyListViewController() -> CurrencyListViewController {
        
        let currencyListViewController = CurrencyDIContainer.create(with: makeCurrencyListViewModel())
        return currencyListViewController
    }
    
    private func makeCurrencyListViewModel() -> CurrencyListViewModel{
        
        return CurrencyListViewModel(currencyUseCase: makeCurrencyUseCase())
    }
    
    static func create(with viewModel: CurrencyListViewModel) -> CurrencyListViewController {
        let viewController = mainStoryBoard.createCurrencyListViewController()
        viewModel.delegate = viewController
        viewController.viewModel = viewModel
        return viewController
    }
    
}
