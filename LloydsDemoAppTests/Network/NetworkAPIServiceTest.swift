//
//  NetworkAPIServiceTest.swift
//  LloydsDemoAppTests
//
//  Created by Niraj Shah on 19/07/22.
//

import XCTest
@testable import LloydsDemoApp

class NetworkAPIServiceTest: XCTestCase {

        func test_whenMalformedUrlPassed_shouldReturnError() {
            
            let expectation = self.expectation(description: "No internet")
            let error = NSError(domain: "network", code: NSURLErrorNotConnectedToInternet, userInfo: nil) as Error
            let networkSessionMock = NetworkManagerMock(response: (nil, error))
            let apiEndpoints = APIEndPointsMock(path: Constants.currencyPath)
            let config = NetworkConfigMock(baseURLPath: "pgy.ghn9")
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
