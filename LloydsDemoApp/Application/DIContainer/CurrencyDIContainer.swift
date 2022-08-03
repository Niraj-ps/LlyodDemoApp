//
//  CurrencyDIContainer.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 18/07/22.
//

import UIKit

final class CurrencyDIContainer {
    
    let mainStoryBoard = LloydsMainStoryboard()

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
        let viewController = mainStoryBoard.createCurrencyListViewController()
        viewModel.delegate = viewController
        viewController.viewModel = viewModel
        return viewController
    }
    
    func create(with viewModel: CurrencyDetailViewModel) -> CurrencyDetailViewController {
        let viewController = mainStoryBoard.createCurrencyDetailViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
    private func makeCurrencyDetailViewModel(currency: Currency) -> CurrencyDetailViewModel{
        return CurrencyDetailViewModel(currency: currency)
    }
    
    func makeCurrencyFlowCoordinator(navigationController: UINavigationController) -> CurrencyFlowCoordinator {
        return CurrencyFlowCoordinator(navigationController: navigationController,
                                           dependencies: self)
    }
}

extension CurrencyDIContainer : CurrencyFlowCoordinatorDependencies {
    
    func makeCurrencyListViewController(actions: CurrencyListViewModelActions) -> CurrencyListViewController {
        let currencyListViewController = self.create(with: makeCurrencyListViewModel(actions : actions))
        return currencyListViewController
    }
    
    func makeCurrencyDetailViewController(currency: Currency) -> UIViewController {
        let currencyListViewController = self.create(with: makeCurrencyDetailViewModel(currency: currency))
        return currencyListViewController
    }
}

