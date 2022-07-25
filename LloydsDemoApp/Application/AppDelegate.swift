//
//  AppDelegate.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 11/07/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var appDIContainer = AppDIContainer()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appDIContainer.loadCurrencyModule(window: window!)
        return true
    }
}
