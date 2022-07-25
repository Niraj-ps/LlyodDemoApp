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
        let currencyString = "{\"EUR\":{\"name\": \"Euro\",\"symbol\": \"€\"}}"
        let data = currencyString.data(using: .utf8)!
        let networkSessionMock = NetworkManagerMock(response: (data, nil))
        let apiEndpoints = APIEndPointsMock(path: Constants.currencyPath)
        let config = NetworkConfigMock(baseURLPath: Constants.apiEndPoint)
        let apiService = NetworkAPIService(sessionManager:networkSessionMock, apiEndPoints: config)
        apiService.perform(request: apiEndpoints).done { data in
            expectation.fulfill()
        }
        .catch { error in
            XCTFail()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func test_whenNotConnectedToInternetReturnNotConnectedError () {

        let expectation = self.expectation(description: "No internet")
        let error = NSError(domain: "network", code: NSURLErrorNotConnectedToInternet, userInfo: nil) as Error
        let networkSessionMock = NetworkManagerMock(response: (nil, error))
        let apiEndpoints = APIEndPointsMock(path: Constants.currencyPath)
        let config = NetworkConfigMock(baseURLPath: Constants.apiEndPoint)
        let apiService = NetworkAPIService(sessionManager:networkSessionMock, apiEndPoints: config)
        apiService.perform(request: apiEndpoints).done { data in
            XCTFail()
        }
        .catch { error in
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
