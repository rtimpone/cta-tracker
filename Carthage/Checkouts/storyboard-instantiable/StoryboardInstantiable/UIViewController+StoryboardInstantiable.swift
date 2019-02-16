//
//  UIViewController+StoryboardInstantiable.swift
//  AutoRegistering
//
//  Created by Rob Timpone on 2/15/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import UIKit

extension UIViewController: StoryboardBased {
    
    // make all view controllers storyboard based by default
}

extension StoryboardInstantiable where Self: UIViewController {
    
    public static func instantiateFromStoryboard() -> Self {
        
        let typeName = String(describing: self)
        let storyboardName = self.storyboardName
        let bundle = Bundle(for: self)
        
        let storyboardFileExtension = "storyboardc"
        let storyboardExists = bundle.path(forResource: storyboardName, ofType: storyboardFileExtension) != nil
        
        guard storyboardExists else {
            fatalError("Unable to find a storyboard named '\(storyboardName)' in the bundle for type '\(typeName)'")
        }
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        guard let initialViewController = storyboard.instantiateInitialViewController() else {
            fatalError("Unable to find an initial view controller in storyboard named '\(storyboardName)'")
        }
        
        guard let instance = initialViewController as? Self else {
            fatalError("The initial view controller in storyboard named '\(storyboardName)' is not of type \(typeName)")
        }
        
        return instance
    }
}

extension UIViewController: StoryboardInstantiable {
    
    // make all view controllers instantiable from storyboards by default
}
