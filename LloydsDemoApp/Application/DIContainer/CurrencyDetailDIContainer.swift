//
//  CurrencyDetailDIContainer.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 04/08/22.
//

import UIKit

final class CurrencyDetailDIContainer {
    
    func create(with viewModel: CurrencyDetailViewModel) -> CurrencyDetailViewController {
        let viewController = CurrencyDetailViewController.instantiate()
        viewController.viewModel = viewModel
        return viewController
    }
    
    private func makeCurrencyDetailViewModel(currency: Currency) -> CurrencyDetailViewModel{
        return CurrencyDetailViewModel(currency: currency)
    }
    
    func makeCurrencyDetailFlowCoordinator(navigationController: UINavigationController?) -> CurrencyDetailFlowCoordinator {
        return CurrencyDetailFlowCoordinator(navigationController: navigationController,
                                           dependencies: self)
    }
}

extension CurrencyDetailDIContainer : CurrencyDetailDependency {
    
    func makeCurrencyDetailViewController(currency: Currency) -> CurrencyDetailViewController {
        let currencyListViewController = self.create(with: makeCurrencyDetailViewModel(currency: currency))
        return currencyListViewController
    }
}
