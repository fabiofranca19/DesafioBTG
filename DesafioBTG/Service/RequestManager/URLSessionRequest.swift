//
//  URLSessionRequest.swift
//  DesafioBTG
//
//  Created by Fábio França on 25/11/20.
//

import Foundation

class URLSessionRequest: RequestManager {
    
    func request<T>(url: URL, method: HTTPMethods, headers: [String : String], completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        
        let request = createRequest(url: url, method: method, headers: headers)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }

            if let data = data {
                do {
                    let object = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(object))
                } catch {
                    debugPrint(error)
                    completion(.failure(error))
                }

            }
        }.resume()
        
        
        
    }
    
    private func createRequest(url: URL, method: HTTPMethods, headers: [String : String]) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.urlRequest
        
        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        return request
    }

    
}

