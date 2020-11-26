//
//  ConversionViewController.swift
//  DesafioBTG
//
//  Created by Fábio França on 25/11/20.
//

import UIKit

class ConversionViewController: UIViewController {
    
    let screen = ConversionScreen()
    var viewModel: ConversionViewModel?
    var coordinator: MainCoordinator?
    
    override func loadView() {
        let view = screen
        self.view = view
    }
    
    override func viewDidLoad() {
        getQuotes()
    }
    
    func getQuotes() {
        viewModel?.getQuotes(completion: { (result) in
            switch result {
            case .failure(let error):
                debugPrint(error)
                break
            case .success(let quotes):
                print(quotes.quotes)
                break
            }
        })
    }
    
    func getCurrencies() {
        viewModel?.getCurrencie(completion: { (result) in
            switch result {
            case .failure(let error):
                break
            case .success(let currencie):
                break
            }
        })
    }
        
}
