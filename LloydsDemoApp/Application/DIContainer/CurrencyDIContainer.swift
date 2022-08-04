//
//  CurrencyDIContainer.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 18/07/22.
//

import UIKit

final class CurrencyDIContainer {
        
    private func makeCurrencyUseCase() -> CurrencyUseCaseProtocol {
        return CurrencyUseCase(currencyRepository: makeCurrencyRepository())
    }
    
    private func makeCurrencyRepository() -> CurrencyRepositoryProtocol {
        return CurrencyRepository(currencyService: makeCurrencyService())
    }
    
    private func makeCurrencyService() -> CurrencyService {
        return CurrencyService(networkManager: makeNetworkManager())
    }
    
    private func makeNetworkManager() -> NetworkManagerProtocol {
        return NetworkManager()
    }
    
    private func makeCurrencyListViewModel(actions : CurrencyListViewModelActions) -> CurrencyListViewModel{
        return CurrencyListViewModel(currencyUseCase: makeCurrencyUseCase(), actions: actions)
    }
    
    func create(with viewModel: CurrencyListViewModel) -> CurrencyListViewController {
        let viewController = CurrencyListViewController.instantiate()
        viewModel.delegate = viewController
        viewController.viewModel = viewModel
        return viewController
    }
    
    func makeCurrencyFlowCoordinator(navigationController: UINavigationController) -> CurrencyListFlowCoordinator {
        return CurrencyListFlowCoordinator(navigationController: navigationController,
                                           dependencies: self)
    }
}

extension CurrencyDIContainer : CurrencyListDependency {
  
    func makeCurrencyListViewController(actions: CurrencyListViewModelActions) -> CurrencyListViewController {
        let currencyListViewController = self.create(with: makeCurrencyListViewModel(actions : actions))
        return currencyListViewController
    }
    
    func makeCurrencyDetailModule() -> CurrencyDetailDIContainer {
        return CurrencyDetailDIContainer()
    }
}

