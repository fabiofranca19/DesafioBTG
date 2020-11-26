//
//  CurrencyLayerSource.swift
//  DesafioBTG
//
//  Created by Fábio França on 25/11/20.
//

import Foundation

protocol APISource {
    func getURL() -> Result<URL, Error>
}

enum CurrencyLayerSource {
    case live(parameters: [String: String])
    case list(parameters: [String: String])
}

extension CurrencyLayerSource: APISource {
    
    func getURL() -> Result<URL, Error> {
        let urlString = "http://api.currencylayer.com/@?access_key=e227fc73032297e11d390e80f975cfc0"
        
        switch self {
        case .list(let parameters):
            
            var urlComps = URLComponents(string: urlString.replacingOccurrences(of: "@", with: "list"))
            
            for parameter in parameters {
                urlComps?.queryItems?.append(URLQueryItem(name: parameter.key, value: parameter.value))
            }
            
            guard let url = urlComps?.url else {
                return .failure(ServiceError.apiError)
            }
            
            return .success(url)
            
        case .live(let parameters):
            var urlComps = URLComponents(string: urlString.replacingOccurrences(of: "@", with: "live"))
            
            for parameter in parameters {
                urlComps?.queryItems?.append(URLQueryItem(name: parameter.key, value: parameter.value))
            }
            
            guard let url = urlComps?.url else {
                return .failure(ServiceError.apiError)
            }
            
            return .success(url)
        }
    }
}

