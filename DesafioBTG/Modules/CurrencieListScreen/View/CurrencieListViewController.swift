//
//  CurrencieListViewController.swift
//  DesafioBTG
//
//  Created by Fábio França on 26/11/20.
//

import UIKit

protocol CurrencieListDelegate {
    func popToConversion(key: String, buttonTag: Int)
}

class CurrencieListViewController: UIViewController {

    var viewModel: CurrencieListViewModel?
    var currencie: CurrencieCollection?
    var delegate: CurrencieListDelegate?
    var screen: CurrencieListScreen?
    var coordinator: MainCoordinator?
    var buttonTag: Int?

    override func loadView() {
        let view = screen
        self.view = view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Currencies"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let currencies = currencie?.currencies {
            screen?.currencies = currencies
            if let currenciesKey = viewModel?.sortedCurrenciesKey(currencies: currencies) {
                screen?.currenciesKey = currenciesKey
            }
        }
    }
    
    func selected(key: String) {
        if let buttonTag = buttonTag {
            delegate?.popToConversion(key: key, buttonTag: buttonTag)
            self.navigationController?.popViewController(animated: true)
        }
    }

}
