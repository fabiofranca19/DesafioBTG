//
//  CurrencieListViewController.swift
//  DesafioBTG
//
//  Created by Fábio França on 26/11/20.
//

import UIKit

class CurrencieListViewController: UIViewController {

    var viewModel: CurrencieListViewModel?
    var currencie: CurrencieCollection? 
    var screen: CurrencieListScreen?
    var coordinator: MainCoordinator?
    
    override func loadView() {
        let view = screen
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screen?.currencies = currencie?.currencies
    }
    


}
