//
//  Currencie.swift
//  DesafioBTG
//
//  Created by Fábio França on 25/11/20.
//

import Foundation

struct CurrencieCollection: Codable {
    let success: Bool
    let currencies: [String:String]
}
