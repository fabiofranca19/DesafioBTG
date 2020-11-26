//
//  CurrencyLayerAPI.swift
//  DesafioBTG
//
//  Created by Fábio França on 25/11/20.
//

import Foundation

class CurrencyLayerAPI {
    
    private let manager: RequestManager
    
    init(manager: RequestManager) {
        self.manager = manager
    }
    
    func getQuotes(completion: @escaping (Result<QuotesCollection,Error>)-> Void) {
        let url = CurrencyLayerSource.live(parameters: ["access_key" : "e227fc73032297e11d390e80f975cfc0"]).getURL()
        
        switch url {
        case .success(let url):
            manager.request(url: url, method: HTTPMethods.get, headers: [:], completion: completion)
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    func getCurrencie(completion: @escaping (Result<CurrencieCollection,Error>)-> Void) {
        let url = CurrencyLayerSource.list(parameters: [:]).getURL()
        
        switch url {
        case .success(let url):
            manager.request(url: url, method: HTTPMethods.get, headers: [:], completion: completion)
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
