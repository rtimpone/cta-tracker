//
//  StatusBarCustomizableNavigationViewController.swift
//  CTATracker
//
//  Created by Rob Timpone on 5/30/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import UIKit

class StatusBarCustomizableNavigationViewController: UINavigationController {
    
    var statusBarStyle: UIStatusBarStyle = .default
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    func setStatusBarStyle(_ style: UIStatusBarStyle) {
        statusBarStyle = style
        setNeedsStatusBarAppearanceUpdate()
    }
}
