//
//  CurrencyServiceTest.swift
//  LloydsDemoAppTests
//
//  Created by Niraj Shah on 24/07/22.
//

import XCTest
@testable import LloydsDemoApp

class CurrencyServiceTest: XCTestCase {
    
    private struct MockModel: Decodable {
        let name: String
    }
    
    func test_whenReceivedValidJsonInResponse_shouldDecodeResponseToDecodableObject() {
        
        let expectation = self.expectation(description: "Should decode mock object")
        let currencyService = CurrencyService(networkManager: NetworkManagerMock(), currencyEndpoint: CurrencyEndpoint(path: "CurrencyListJson"))
        currencyService.requestCurrencyList { result in
            do {
                let object = try result.get()
                XCTAssertTrue(object.count > 0)
                expectation.fulfill()
            } catch {
                XCTFail("Failed decoding MockObject")
            }
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func test_whenRecievedInValidJson_throwsError() {
        
        let expectation = self.expectation(description: "Invalid Json")
        let currencyService = CurrencyService(networkManager: NetworkManagerMock(), currencyEndpoint: CurrencyEndpoint(path: "CurrencyInvalidJson"))
        currencyService.requestCurrencyList { result in
            do {
                let _ = try result.get()
                XCTFail()
                
            } catch {
                XCTAssertTrue(true)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
    }
    
}
