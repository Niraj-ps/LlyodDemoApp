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

    func test_shouldReturnProperResponse() {

        let expectation = self.expectation(description: "Return proper data that is passed")
        let networkManager = NetworkManagerMock(filePath: "CurrencyListJson")
        let apiEndpoints = CurrencyEndPointMock.currencyJSON
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

    func test_ShouldReturnErrorIfFailedToFetchdData() {

        let expectation = self.expectation(description: "Should return error")
        let networkManager = NetworkManagerMock(filePath: "CurrencyInvalidJson")
        let apiEndpoints = CurrencyEndPointMock.currencyInvalidJSON
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
