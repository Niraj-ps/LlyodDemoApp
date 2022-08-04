//
//  CurrencyDetailFlowCoordinator.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 04/08/22.
//

import UIKit

protocol CurrencyDetailDependency {
    func makeCurrencyDetailViewController(currency: Currency) -> CurrencyDetailViewController
}

final class CurrencyDetailFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: CurrencyDetailDependency
    let currency : Currency!
    
    init(navigationController: UINavigationController?, dependencies : CurrencyDetailDependency, currency : Currency) {
        self.navigationController = navigationController
        self.dependencies = dependencies
        self.currency = currency
    }
    
    func start() {
        let currencyDetailVC = dependencies.makeCurrencyDetailViewController(currency: currency)
        navigationController?.pushViewController(currencyDetailVC, animated: true)
    }
}
