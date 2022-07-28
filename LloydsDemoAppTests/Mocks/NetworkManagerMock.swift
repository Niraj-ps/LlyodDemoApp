//
//  NetworkManagerMock.swift
//  LloydsDemoAppTests
//
//  Created by Niraj Shah on 22/07/22.
//

@testable import LloydsDemoApp
import PromiseKit

class NetworkManagerMock : NetworkManagerProtocol {
    
    var filePath : String
    init(filePath : String = ""){
        self.filePath = filePath
    }
    
    func request<T>(endpoint: Endpoint, responseModel: T.Type) -> Promise<T> where T : Decodable {
        
        return Promise { seal in
        let testBundle = Bundle(for: type(of: self))
        if let url = testBundle.url(forResource: filePath, withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(responseModel.self, from: data)
                    seal.fulfill(jsonData)
                } catch {
                    seal.reject(NetworkError.parseFailed)
                }
            }
            else{
                seal.reject(NetworkError.invalidURL)
            }
        }
    }
}
