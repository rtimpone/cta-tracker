//
//  AppDelegate.swift
//  CTATracker
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = HomeViewController.instantiateFromStoryboard()
        let nvc = ThemeableNavigationViewController(rootViewController: vc)
        window?.rootViewController = nvc
        window?.makeKeyAndVisible()
        
        return true
    }
}
