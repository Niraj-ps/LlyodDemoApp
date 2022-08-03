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
}
