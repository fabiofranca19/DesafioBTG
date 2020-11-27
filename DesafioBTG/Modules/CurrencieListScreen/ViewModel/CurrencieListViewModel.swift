//
//  CurrencieListViewModel.swift
//  DesafioBTG
//
//  Created by Fábio França on 26/11/20.
//

import Foundation

class CurrencieListViewModel {
    
    func sortedCurrenciesKey(currencies: [String:String]) -> [String]{
        var currenciesKey = [String]()
        for(key,_) in currencies {
            currenciesKey.append(key)
        }
        currenciesKey = currenciesKey.sorted{ $0 < $1 }
        return currenciesKey
    }
}
