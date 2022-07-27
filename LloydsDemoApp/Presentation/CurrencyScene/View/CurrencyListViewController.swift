//
//  CurrencyListViewController.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 11/07/22.
//

import UIKit

protocol CurrencyViewProtocol: AnyObject {
    func updateItemData()
}

class CurrencyListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    var viewModel: CurrencyListViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.requestCurrencyAPI()
        self.navigationItem.title = Constants.currencyListText
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
        return viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        cell.isAccessibilityElement = true
        cell.accessibilityIdentifier = "curCell"
        let currData = viewModel.getCurrencyAt(index: indexPath.row)
        cell.textLabel?.text = currData.currencyName
        cell.accessibilityLabel = currData.currencyName
        return cell
    }
}

extension CurrencyListViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel.updateCurencyListUsingSearch(text : searchBar.text!)
    }
        
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.updateCurencyListUsingSearch(text : searchBar.text!)
    }
}
