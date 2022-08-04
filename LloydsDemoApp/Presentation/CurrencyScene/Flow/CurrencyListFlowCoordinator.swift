//
//  CurrencyListFlowCoordinator.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 03/08/22.
//

import UIKit

protocol CurrencyListDependency {
    func makeCurrencyListViewController(actions: CurrencyListViewModelActions) -> CurrencyListViewController
    func makeCurrencyDetailModule() -> CurrencyDetailDIContainer
}

final class CurrencyListFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: CurrencyListDependency

    init(navigationController: UINavigationController, dependencies : CurrencyListDependency) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = CurrencyListViewModelActions(showCurrencyDetails: showCurrencyDetails)
        let vc = dependencies.makeCurrencyListViewController(actions: actions)
        navigationController?.pushViewController(vc, animated: false)
    }
    
    private func showCurrencyDetails(currency: Currency) {
        let currencyDetailDIContainer = dependencies.makeCurrencyDetailModule()
        let flow = currencyDetailDIContainer.makeCurrencyDetailFlowCoordinator(navigationController: navigationController)
        flow.start(with: currency)
    }
}
