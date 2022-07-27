//
//  NetworkManagerTest.swift
//  LloydsDemoAppTests
//
//  Created by Niraj Shah on 22/07/22.
//

import XCTest
@testable import LloydsDemoApp
import PromiseKit

class NetworkManagerTest : XCTestCase {

    func test_whenMockDataPassed_shouldReturnProperResponse() {

        let expectation = self.expectation(description: "Return proper data that is passed")
        let networkManager = NetworkManagerMock()
        let apiEndpoints = CurrencyEndpoint(path: "CurrencyListJson")
        var currencyResponse : CurrencyResponse?
        networkManager.request(endpoint:apiEndpoints, responseModel: CurrencyResponse.self).done { response in
            currencyResponse =  response
            expectation.fulfill()
        }
        .catch { error in
            XCTFail()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(currencyResponse)
    }

    func test_whenNotConnectedToInternetReturnNotConnectedError () {

        let expectation = self.expectation(description: "Return proper data that is passed")
        let networkManager = NetworkManagerMock()
        let apiEndpoints = CurrencyEndpoint(path: "currency")
        var currencyResponse : CurrencyResponse?
        networkManager.request(endpoint:apiEndpoints, responseModel: CurrencyResponse.self).done { response in
            currencyResponse =  response
            XCTFail()
        }
        .catch { error in
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertNil(currencyResponse)

    }
}
