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
    
    var flag = true
    
    var quotesWasFetched = false {
        didSet{
            if currenciesWasFetched {
                DispatchQueue.main.async { [self] in
                    loading(false)
                    if let currencie = currencie?.currencies {
                        screen?.changeBtnTitle(key: "USD", value: currencie["USD"] ?? "", buttonTag: 0)
                        screen?.changeBtnTitle(key: "BRL", value: currencie["BRL"] ?? "", buttonTag: 1)
                        screen?.convertTapped()
                    }
                }
            }
        }
    }
    var currenciesWasFetched = false {
        didSet {
            if quotesWasFetched {
                DispatchQueue.main.async { [self] in
                    loading(false)
                    if let currencie = currencie?.currencies {
                        screen?.changeBtnTitle(key: "USD", value: currencie["USD"] ?? "", buttonTag: 0)
                        screen?.changeBtnTitle(key: "BRL", value: currencie["BRL"] ?? "", buttonTag: 1)
                        screen?.convertTapped()
                    }
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
        self.navigationItem.title = "Conversion"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let currencie = currencie , let _ = quotes {
            if flag {
                screen?.changeBtnTitle(key: "USD", value: currencie.currencies["USD"] ?? "", buttonTag: 0)
                screen?.changeBtnTitle(key: "BRL", value: currencie.currencies["BRL"] ?? "", buttonTag: 1)
                flag = false
            }
            
            screen?.originTF.text = "1"
            screen?.convertTapped()
        }
    }
    
    func loading(_ isLoading: Bool) {
        screen?.loading(isLoading)
    }
    
    func destinationTapped(buttonTag: Int) {
        guard let currencie = currencie else {
            return
        }
        coordinator?.currencieListTapped(delegate: self, currencie: currencie, buttonTag: buttonTag)
    }
    
    func originTapped(buttonTag: Int) {
        guard let currencie = currencie else {
            return
        }
        coordinator?.currencieListTapped(delegate: self, currencie: currencie, buttonTag: buttonTag)
    }
    
    func convertTapped(originValue: Double,originKey: String,destinationKey: String) {
        guard let quotes = quotes?.quotes else {
            return
        }
        
        if let quoteOrigin = quotes["USD\(originKey)"], let quoteDestination = quotes["USD\(destinationKey)"] {
            if let valueConverted = viewModel?.convert(originQuote: quoteOrigin, destinationQuote: quoteDestination, originValue: originValue) {
                screen?.valueWasConverted(convertedValue: valueConverted)
            }
        }
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

extension ConversionViewController: CurrencieListDelegate {
    func popToConversion(key: String, buttonTag: Int) {
        if let currencie = currencie?.currencies {
            screen?.changeBtnTitle(key: key, value: currencie[key] ?? "", buttonTag: buttonTag)
        }
    }
}
