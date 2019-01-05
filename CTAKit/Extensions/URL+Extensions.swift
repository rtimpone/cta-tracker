//
//  URL+Extensions.swift
//  CTAKit
//
//  Created by Rob Timpone on 12/21/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import Foundation

extension URL {
    
    init?(string: String, parameters: [String: String]) {
        
        var paramsString = ""
        var isFirstParam = true
        
        //sorting keys for testability (so this method will always return the same result given the same input)
        let sortedKeys = parameters.keys.sorted()
        for key in sortedKeys {
            
            let prefix = isFirstParam ? "?" : "&"
            isFirstParam = false
            
            guard let value = parameters[key] else {
                continue
            }
            
            paramsString += "\(prefix)\(key)=\(value)"
        }
        
        let urlStringWithParams = string + paramsString
        self.init(string: urlStringWithParams)
    }
}
