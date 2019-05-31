//
//  StatusBarCustomizableNavigationViewController.swift
//  CTATracker
//
//  Created by Rob Timpone on 5/30/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import UIKit

class ThemeableNavigationViewController: UINavigationController {
    
    var statusBarStyle: UIStatusBarStyle = .default
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
}

extension ThemeableNavigationViewController: Themeable {
    
    func applyTheme(_ theme: Theme) {
        
        statusBarStyle = theme.statusBarTheme.style
        setNeedsStatusBarAppearanceUpdate()
        
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: theme.navBarTheme.titleColor]
        navigationBar.tintColor = theme.navBarTheme.buttonColor
        navigationBar.barTintColor = theme.navBarTheme.backgroundColor
    }
}
