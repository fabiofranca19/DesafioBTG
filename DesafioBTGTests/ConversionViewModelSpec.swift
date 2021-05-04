//
//  ConversionViewModelSpec.swift
//  DesafioBTGTests
//
//  Created by Fábio França Costa Júnior on 04/05/21.
//

import XCTest
@testable import DesafioBTG
class ConversionViewModelSpec: XCTestCase {

    var viewModel: ConversionViewModel?
    var api: CurrencyLayerAPI?
    var manager: RequestManagerMock?
    
    override func setUpWithError() throws {
        manager = RequestManagerMock(status: .success, json: jsonLive.data(using: .utf8)!)
        api = CurrencyLayerAPI(manager: manager!)
        viewModel = ConversionViewModel(api: api!)
    }
    
    func testGetQuotesSuccess() {
        manager?.status = .success
        
        var count = 0
        let exp = expectation(description: "Loading Quotes")
        
        viewModel?.getQuotes(completion: { result in
            switch result {
            case .success(let quotes):
                count = quotes.quotes.count
            default:
                break
            }
            exp.fulfill()
        })
        
        wait(for: [exp], timeout: 5.0)
        
        XCTAssertEqual(count, 168, "We should have loaded exactly 168 quotes.")
    }
    
    func testGetCurrencie() {
        manager = RequestManagerMock(status: .success, json: jsonList.data(using: .utf8)!)
        api = CurrencyLayerAPI(manager: manager!)
        viewModel = ConversionViewModel(api: api!)
        
        var count = 0
        let exp = expectation(description: "Loading Currencie")
        
        viewModel?.getCurrencie(completion: { result in
            switch result {
            case .success(let currencies):
                count = currencies.currencies.count
            default:
                break
            }
            exp.fulfill()
        })
        
        wait(for: [exp], timeout: 5.0)
        
        XCTAssertEqual(count, 168, "We should have loaded exactly 168 currncie.")
    }

    func testConvert() {
        let value = viewModel?.convert(originQuote: 2.0, destinationQuote: 4.0, originValue: 2.0)
        XCTAssertTrue(value == 4.0)
    }

}
