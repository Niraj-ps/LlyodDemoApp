//
//  CurrencyFlowCoordinator.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 03/08/22.
//

import UIKit

protocol CurrencyFlowCoordinatorDependencies {
    func makeCurrencyListViewController(actions: CurrencyListViewModelActions) -> CurrencyListViewController
    func makeCurrencyDetailViewController(currency: Currency) -> UIViewController
}

final class CurrencyFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: CurrencyFlowCoordinatorDependencies

    init(navigationController: UINavigationController, dependencies : CurrencyFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = CurrencyListViewModelActions(showCurrencyDetails: showCurrencyDetails)
        let vc = dependencies.makeCurrencyListViewController(actions: actions)
        navigationController?.pushViewController(vc, animated: false)
    }
    
    private func showCurrencyDetails(currency: Currency) {
        let vc = dependencies.makeCurrencyDetailViewController(currency: currency)
        navigationController?.pushViewController(vc, animated: true)
    }
}
