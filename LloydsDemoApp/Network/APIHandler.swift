//
//  APIHandler.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 13/07/22.
//

import Foundation


protocol RequestHandler {
    func makeRequest() -> URLRequest?
}

protocol ResponseHandler {
    associatedtype ResponseDataType
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> ResponseDataType
}

typealias APIHandler = RequestHandler & ResponseHandler

