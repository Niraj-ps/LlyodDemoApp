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

    init(navigationController: UINavigationController?, dependencies : CurrencyDetailDependency) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start(with currency : Currency) {
        let vc = dependencies.makeCurrencyDetailViewController(currency: currency)
        navigationController?.pushViewController(vc, animated: true)
    }
}
