//
//  RequestHandler.swift
//  CTATracker
//
//  Created by Rob Timpone on 2/27/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CTAKit

enum RequestHandlerResult<T> {
    
    case success(T)
    case error
    
    var value: T? {
        if case .success(let object) = self {
            return object
        }
        else {
            return nil
        }
    }
}

class RequestHandler {
    let client = CtaClient()
}
