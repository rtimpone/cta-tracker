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
        guard let themeName = UserDefaultsClient.fetchValue(forKey: key) as? String else {
            return defaultTheme
        }
        return Theme.themeWithName(themeName) ?? defaultTheme
    }
    
    static func setCurrentTheme(_ theme: Theme) {
        UserDefaultsClient.setValue(theme.name, forKey: key)
    }
}
