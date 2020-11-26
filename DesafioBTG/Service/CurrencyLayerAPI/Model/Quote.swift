//
//  Quote.swift
//  DesafioBTG
//
//  Created by Fábio França on 25/11/20.
//

import Foundation

struct QuotesCollection: Codable {
    let success: Bool
    let quotes: [String: Double]
}
