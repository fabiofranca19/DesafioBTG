//
//  ConversionViewModel.swift
//  DesafioBTG
//
//  Created by Fábio França on 26/11/20.
//

import Foundation

class ConversionViewModel {
    let api: CurrencyLayerAPI
    
    init(api: CurrencyLayerAPI) {
        self.api = api
    }
    
    func getQuotes(completion: @escaping (Result<QuotesCollection,Error>)-> Void) {
        api.getQuotes(completion: completion)
    }
    
    func getCurrencie(completion: @escaping (Result<CurrencieCollection,Error>)-> Void) {
        api.getCurrencie(completion: completion)
    }
    
    func convert(originQuote: Double, destinationQuote: Double, originValue: Double) -> Double{
        if destinationQuote == 1 {
            return Double(originValue / originQuote).arredonda(casasDecimais: 2)
        }
        let originConvertedDollar = originValue / originQuote
        return Double(destinationQuote * originConvertedDollar).arredonda(casasDecimais: 2)
    }

}
