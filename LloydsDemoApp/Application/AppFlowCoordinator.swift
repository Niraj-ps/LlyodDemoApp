//
//  AppFlowCoordinator.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 03/08/22.
//

import UIKit

final class AppFlowCoordinator {
    
    var window: UIWindow?
    private let appDIContainer: AppDIContainer
    private let navigationController = UINavigationController()
    
    init(window: UIWindow?, appDIContainer: AppDIContainer) {
        self.window = window
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        window?.rootViewController = navigationController
        loadCurrencyModule()
        window?.makeKeyAndVisible()
    }
    
    private func loadCurrencyModule() {
        let currencyDIContainer = appDIContainer.makeCurrencyDIContainer()
        let flow = currencyDIContainer.makeCurrencyFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}
