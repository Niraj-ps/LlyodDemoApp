//
//  AppDIContainer.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 18/07/22.
//

import Foundation
import UIKit

final class AppDIContainer {
        
    func makeCurrencyDIContainer() -> CurrencyDIContainer {
        
        return CurrencyDIContainer()
    }
    
    func makeCurrencyListViewController() -> CurrencyListViewController {
        let currencyDIContainer = makeCurrencyDIContainer()
        return currencyDIContainer.makeCurrencyListViewController()
    }
    
    func loadCurrencyModule(window : UIWindow) {
        let listViewController = makeCurrencyListViewController()
        window.rootViewController = UINavigationController(
            rootViewController: listViewController
        )
    }
}
