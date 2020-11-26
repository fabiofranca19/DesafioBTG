//
//  Coordinator.swift
//  DesafioBTG
//
//  Created by Fábio França on 26/11/20.
//

import UIKit

class MainCoordinator {
    var nav: UINavigationController
    var currencieApi: CurrencyLayerAPI
    
    init(nav: UINavigationController,currencieApi: CurrencyLayerAPI ) {
        self.nav = nav
        self.currencieApi = currencieApi
    }
    
    func start() {
        let viewModel = ConversionViewModel(api: currencieApi)
        let vc = ConversionViewController()
        vc.viewModel = viewModel
        vc.coordinator = self
        nav.pushViewController(vc, animated: false)
    }
    
    func currencieListTapped() {
        
    }
}
