//
//  LloydsMainStoryboard.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 22/07/22.
//

import Foundation
import UIKit

protocol StoryboardProtocol {
    func createCurrencyListViewController() -> CurrencyListViewController
}

class LloydsMainStoryboard {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
}

extension LloydsMainStoryboard : StoryboardProtocol {
    func createCurrencyListViewController() -> CurrencyListViewController {
        guard let vc = storyboard.instantiateViewController(withIdentifier: "CurrencyListViewController") as? CurrencyListViewController else {
                fatalError("Not initialised")
            }
        return vc
    }
}
