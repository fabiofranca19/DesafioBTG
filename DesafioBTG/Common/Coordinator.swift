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
        let screen = ConversionScreen()
        let viewModel = ConversionViewModel(api: currencieApi)
        let vc = ConversionViewController()
        vc.viewModel = viewModel
        vc.screen = screen
        screen.origin = vc.originTapped
        screen.destination = vc.destinationTapped
        screen.convert = vc.convertTapped
        vc.coordinator = self
        nav.pushViewController(vc, animated: false)
    }
    
    func currencieListTapped(currencie: CurrencieCollection) {
        let screen = CurrencieListScreen()
        let viewModel = CurrencieListViewModel()
        let vc = CurrencieListViewController()
        vc.viewModel = viewModel
        vc.currencie = currencie
        vc.screen = screen
        vc.coordinator = self
        screen.selected = vc.selected(key:)
        nav.pushViewController(vc, animated: true)
    }
}
