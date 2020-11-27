//
//  Double+Arredonda.swift
//  DesafioBTG
//
//  Created by Fábio França on 27/11/20.
//

import Foundation

extension Double {
    /// Arredonda um Double conforme quantidade de casas decimaisx
    func arredonda(casasDecimais: Int) -> Double {
        var formatacao:String {
            let formatacao = NumberFormatter()
            formatacao.minimumFractionDigits = casasDecimais
            return formatacao.string(from: NSNumber(value: self))!
            
        }
        return Double(formatacao)!
        
    }
}
