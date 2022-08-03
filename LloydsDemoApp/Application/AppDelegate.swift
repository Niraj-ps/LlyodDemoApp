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
    let appDIContainer = AppDIContainer()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let appFlowCoordinator = AppFlowCoordinator(window: window, appDIContainer: appDIContainer)
        appFlowCoordinator.start()
        return true
    }
}
