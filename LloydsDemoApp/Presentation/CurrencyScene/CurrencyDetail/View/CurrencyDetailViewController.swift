//
//  CurrencyDetailViewController.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 03/08/22.
//

import UIKit

class CurrencyDetailViewController: UIViewController {

    var viewModel: CurrencyDetailViewModelProtocol!
    @IBOutlet weak var currencyCode: UILabel!
    @IBOutlet weak var currencySymbol: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.title
        self.currencySymbol.text = viewModel.symbol
        self.currencyCode.text = viewModel.code
    }
}
