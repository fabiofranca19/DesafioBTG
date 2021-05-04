//
//  RequestManagerMock.swift
//  DesafioBTGTests
//
//  Created by Fábio França Costa Júnior on 04/05/21.
//

@testable import DesafioBTG
import Foundation

class RequestManagerMock: RequestManager {
    enum Status {
        case success
        case emptyData
        case connectionError
        case apiError
    }
    
    var status: Status
    let json: Data
    
    init(status: Status, json: Data) {
        self.status = status
        self.json = json
    }
    
    func request<T>(url: URL, method: HTTPMethods, headers: [String : String], userDefaultsKey: String, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        switch status {
        case .success:
            print("success")
            let entityType: T = try! json.decoded()
            completion(.success(entityType))
        case .emptyData:
            print("empty data")
            completion(.failure(ServiceError.emptyData))
        case .connectionError:
            completion(.failure(ServiceError.connectionError))
        case .apiError:
            completion(.failure(ServiceError.apiError))
        }
    }
}


extension Data {
    func decoded<T: Decodable>() throws -> T {
        return try JSONDecoder().decode(T.self, from: self)
    }
}
