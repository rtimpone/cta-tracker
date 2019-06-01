//
//  Animator.swift
//  CTATracker
//
//  Created by Rob Timpone on 2/27/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import UIKit

class Animator {
    
    static func animateChangesInView(_ rootView: UIView, duration: TimeInterval, changes: @escaping () -> Void) {
        UIView.transition(with: rootView,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {
                              changes()
                          },
                          completion: nil)
    }
}
