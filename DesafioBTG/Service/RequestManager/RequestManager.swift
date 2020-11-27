//
//  RequestManager.swift
//  DesafioBTG
//
//  Created by Fábio França on 25/11/20.
//

import Foundation

protocol RequestManager {
    func request<T:Decodable>(url: URL, method: HTTPMethods,headers:[String:String],userDefaultsKey: String,completion: @escaping(Result<T,Error>) -> Void)
}

enum RequestManagerFactory {
    case urlsession
    
    func create() -> RequestManager {
        switch self {
        case .urlsession:
            return URLSessionRequest()
        }
    }
}

enum HTTPMethods: String {
    case get
    case post
    
    var urlRequest: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }
}

enum ServiceError: Error{
    case emptyData
    case connectionError
    case apiError
    
    var localizedDescription: String{
        switch self {
        case .apiError:
            return "Algo deu Errado."
        case .emptyData:
        return "Nada foi encontrado."
        case .connectionError:
        return "Você Não está conectado."
        }
    }
}

