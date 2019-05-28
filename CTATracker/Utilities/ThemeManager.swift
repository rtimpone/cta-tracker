//
//  ThemeManager.swift
//  CTATracker
//
//  Created by Rob Timpone on 5/28/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import Foundation

struct ThemeManager {
    
    static let key = "currentTheme"
    static let defaultTheme = LightTheme()
    
    static func currentTheme() -> Theme {
        return UserDefaultsClient.fetchValue(forKey: key) as? Theme ?? defaultTheme
    }
    
    static func setCurrentTheme(_ theme: Theme) {
        UserDefaultsClient.setValue(theme, forKey: key)
    }
}
