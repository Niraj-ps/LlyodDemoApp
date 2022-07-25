//
//  APIEndPoints.swift
//  LloydsDemoApp
//
//  Created by Niraj Shah on 18/07/22.
//

import Foundation

protocol NetworkConfigProtocol {
    var baseURLPath : String { get }
}

public struct NetworkConfiguration : NetworkConfigProtocol {
    public let baseURLPath: String
    
     public init(baseURLPath : String) {
        self.baseURLPath = baseURLPath
    }
}
