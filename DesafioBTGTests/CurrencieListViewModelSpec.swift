//
//  CurrencieListViewModelSpec.swift
//  DesafioBTGTests
//
//  Created by Fábio França Costa Júnior on 04/05/21.
//

import XCTest
@testable import DesafioBTG

class CurrencieListViewModelSpec: XCTestCase {
    var viewModel: CurrencieListViewModel?
    
    override func setUpWithError() throws {
        viewModel = CurrencieListViewModel()
    }
    
    func testSortedCurrenciesKey() {
        let currencies: [String: String] = ["GNF": "Guinean Franc",
                                            "BBD":"Barbadian Dollar",
                                            "ANG":"Netherlands Antillean Guilder",
                                            "AMD": "Armenian Dram"]
        
        let newCurrencies = viewModel?.sortedCurrenciesKey(currencies: currencies)
        
        XCTAssert(newCurrencies == ["AMD", "ANG", "BBD", "GNF"])
    }
}
