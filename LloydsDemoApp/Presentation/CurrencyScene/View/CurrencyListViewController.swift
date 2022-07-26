//
//  CurrencyListViewController.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 11/07/22.
//

import UIKit

protocol CurrencyViewProtocol {
    func updateItemData()
}

class CurrencyListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var viewModel : CurrencyListViewModel!
    static var mainStoryBoard = LloydsMainStoryboard()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.requestAPIData(currencyViewDelegate : self)
        self.navigationItem.title = Constants.currencyListText
    }
    
    static func create(with viewModel: CurrencyListViewModel) -> CurrencyListViewController {
        let viewController = mainStoryBoard.createCurrencyListViewController()
        viewController.viewModel = viewModel
        return viewController
    }

}

extension CurrencyListViewController : CurrencyViewProtocol {
    func updateItemData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension CurrencyListViewController : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return viewModel.searchItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        cell.isAccessibilityElement = true
        cell.accessibilityIdentifier = "curCell"
        let currData = viewModel.searchItems[indexPath.row]
        cell.textLabel?.text = currData.currencyName
        cell.accessibilityLabel = currData.currencyName

        return cell
    }
}

extension CurrencyListViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel.searchCurrencyList(text : searchBar.text!)
    }
        
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            viewModel.searchCurrencyList(text : searchBar.text!)
    }
}
