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
        let responseData = #"{"name": "Hello"}"#.data(using: .utf8)
        let networkAPIservice = NetworkAPIServiceMock(data: responseData!, error: nil)
        let currencyService = CurrencyService(networkServices: networkAPIservice)
        let apiEndpoint = APIEndpoints(path: Constants.currencyPath)
        currencyService.request (endpoints: apiEndpoint) { (result : Result<MockModel , NetworkError>) in
            do {
                let object = try result.get()
                XCTAssertEqual(object.name, "Hello")
                expectation.fulfill()
            } catch {
                XCTFail("Failed decoding MockObject")
            }
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func test_whenRecievedDataNotDecode() {
        
        let expectation = self.expectation(description: "Should decode mock object")
        let responseData = "abc".data(using: .utf8)
        let networkAPIservice = NetworkAPIServiceMock(data: responseData, error: nil)
        let currencyService = CurrencyService(networkServices: networkAPIservice)
        let apiEndpoint = APIEndpoints(path: Constants.currencyPath)
        currencyService.request (endpoints: apiEndpoint) { (result : Result<MockModel , NetworkError>) in
            do {
                let _ = try result.get()
            } catch {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
    }
    
}
