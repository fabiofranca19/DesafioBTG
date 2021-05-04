//
//  Quote.swift
//  DesafioBTG
//
//  Created by Fábio França on 25/11/20.
//

import Foundation

struct QuotesCollection: Codable {
    let success: Bool
    //let source: String
    let quotes: [String: Double]
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
//        case source = "source"
        case quotes = "quotes"
    }
}
