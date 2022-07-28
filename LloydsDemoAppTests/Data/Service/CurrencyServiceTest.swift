import XCTest
@testable import LloydsDemoApp

class CurrencyServiceTest: XCTestCase {
    
    func test_whenReceivedValidJsonInResponse_shouldDecodeResponseToDecodableObject() {
        
        let expectation = self.expectation(description: "Should decode mock object")
        let currencyService = CurrencyService(networkManager: NetworkManagerMock(filePath: "CurrencyListJson"))
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
        let currencyService = CurrencyService(networkManager: NetworkManagerMock(filePath: "CurrencyInvalidJson"))
        var invalidJSONError : Error?
        currencyService.requestCurrencyList { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                if let tempError = error as? NetworkError, tempError == .parseFailed {
                    invalidJSONError = tempError
                }
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(invalidJSONError)
    }
    
    func test_whenRecievedInValidURL_throwsError(){

        let expectation = self.expectation(description: "Invalid URL")
        let currencyService = CurrencyService(networkManager: NetworkManagerMock(filePath: "4jk./}jik"))
        var invalidURLError : NetworkError?
        currencyService.requestCurrencyList { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                if let tempError = error as? NetworkError, tempError == .invalidURL {
                    invalidURLError = tempError
                }
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(invalidURLError)
    }
}
