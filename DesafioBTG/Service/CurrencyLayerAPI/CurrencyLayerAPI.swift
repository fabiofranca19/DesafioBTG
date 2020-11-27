//
//  CurrencyLayerAPI.swift
//  DesafioBTG
//
//  Created by Fábio França on 25/11/20.
//

import Foundation
import Network

class CurrencyLayerAPI {
    
    private let manager: RequestManager
    let monitor = NWPathMonitor()
    let defaults = UserDefaults.standard
    
    init(manager: RequestManager) {
        self.manager = manager
    }
    
    func getQuotes(completion: @escaping (Result<QuotesCollection,Error>)-> Void) {
        let url = CurrencyLayerSource.live(parameters: ["access_key" : "e227fc73032297e11d390e80f975cfc0"]).getURL()
        
        monitor.pathUpdateHandler = { [self] path in
            if path.status == .satisfied {
                print("Connected")
                switch url {
                case .success(let url):
                    manager.request(url: url, method: HTTPMethods.get, headers: [:], userDefaultsKey: "quotes", completion: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            } else {
                print("Disconnected")
                if let quotesData = defaults.object(forKey: "quotes") as? Data {
                    let decoder = JSONDecoder()
                    if let quotes = try? decoder.decode(QuotesCollection.self, from: quotesData){
                        completion(.success(quotes))
                    }else{
                        completion(.failure(ServiceError.emptyData))
                    }
                }else {
                    completion(.failure(ServiceError.connectionError))
                }
            }
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
        
    }
    
    func getCurrencie(completion: @escaping (Result<CurrencieCollection,Error>)-> Void) {
        let url = CurrencyLayerSource.list(parameters: [:]).getURL()
        
        monitor.pathUpdateHandler = { [self] path in
            if path.status == .satisfied {
                print("Connected")
                switch url {
                case .success(let url):
                    manager.request(url: url, method: HTTPMethods.get, headers: [:], userDefaultsKey: "currencie", completion: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            } else {
                print("Disconnected")
                if let currencieData = defaults.object(forKey: "currencie") as? Data {
                    let decoder = JSONDecoder()
                    if let currencie = try? decoder.decode(CurrencieCollection.self, from: currencieData){
                        completion(.success(currencie))
                    }else{
                        completion(.failure(ServiceError.emptyData))
                    }
                }else {
                    completion(.failure(ServiceError.connectionError))
                }
            }
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
        
    }
}
