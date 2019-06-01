//
//  UserDefaultsClient.swift
//  CTATracker
//
//  Created by Rob Timpone on 5/28/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import Foundation

struct UserDefaultsClient {
    
    static func setValue(_ value: Any, forKey key: String) {
        UserDefaults.standard.setValue(value, forKey: key)
    }
    
    static func fetchValue(forKey key: String) -> Any? {
        return UserDefaults.standard.value(forKey: key)
    }
    
    static func setArray(_ array: [Any], forKey key: String) {
        UserDefaults.standard.set(array, forKey: key)
    }
    
    static func fetchArray(forKey key: String) -> [Any]? {
        return UserDefaults.standard.array(forKey: key)
    }
}
