//
//  UIViewController+Extensions.swift
//  CTATracker
//
//  Created by Rob Timpone on 5/26/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func add(child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
}
