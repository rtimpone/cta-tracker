//
//  ApiLogger.swift
//  CTAKit
//
//  Created by Rob Timpone on 1/5/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import Foundation

public protocol ApiLogger {
    func logHttpResponse(_ response: HTTPURLResponse?, toRequest request: URLRequest)
}

public class ConsoleApiLogger: ApiLogger {
    
    public init() {}
    
    public func logHttpResponse(_ response: HTTPURLResponse?, toRequest request: URLRequest) {
        
        let httpMethod = request.httpMethod ?? "???"
        let urlString = request.url?.absoluteString ?? "(URL unavailable)"

        if let response = response {
            print("(\(response.statusCode)) \(httpMethod) \(urlString)")
        }
        else {
            print("[NO RESPONSE] \(httpMethod) \(urlString)")
        }
    }
}
