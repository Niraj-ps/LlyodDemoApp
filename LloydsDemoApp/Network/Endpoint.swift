//
//  EndPoint.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 24/07/22.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }
    var host: String {
        return Constants.host
    }
}
