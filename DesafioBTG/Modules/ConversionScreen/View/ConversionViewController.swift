//
//  ConversionViewController.swift
//  DesafioBTG
//
//  Created by Fábio França on 25/11/20.
//

import UIKit

class ConversionViewController: UIViewController {
    
    var screen: ConversionScreen?
    var viewModel: ConversionViewModel?
    var coordinator: MainCoordinator?
    
    var quotes: QuotesCollection?
    var currencie: CurrencieCollection?
    
    var quotesWasFetched = false {
        didSet{
            if currenciesWasFetched {
                DispatchQueue.main.async { [self] in
                    loading(false)
                }
            }
        }
    }
    var currenciesWasFetched = false {
        didSet {
            if quotesWasFetched {
                DispatchQueue.main.async { [self] in
                    loading(false)
                }
            }
        }
    }
    
    override func loadView() {
        let view = screen
        self.view = view
        loading(true)
    }
    
    override func viewDidLoad() {
        getQuotes()
        getCurrencies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func loading(_ isLoading: Bool) {
        screen?.loading(isLoading)
    }
    
    func destinationTapped() {
        guard let currencie = currencie else {
            return
        }
        coordinator?.currencieListTapped(currencie: currencie)
    }
    
    func originTapped() {
        guard let currencie = currencie else {
            return
        }
        coordinator?.currencieListTapped(currencie: currencie)
    }
    
    func convertTapped() {
        
    }
    
    func getQuotes() {
        viewModel?.getQuotes(completion: { [self] (result) in
            switch result {
            case .failure(let error):
                debugPrint(error)
                break
            case .success(let quotes):
                quotesWasFetched = true
                self.quotes = quotes
                break
            }
        })
    }
    
    func getCurrencies() {
        viewModel?.getCurrencie(completion: { [self] (result) in
            switch result {
            case .failure(let error):
                debugPrint(error)
                break
            case .success(let currencie):
                currenciesWasFetched = true
                self.currencie = currencie
                break
            }
        })
    }
        
}
