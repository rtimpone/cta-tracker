//
//  Animator.swift
//  CTATracker
//
//  Created by Rob Timpone on 2/27/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import UIKit

class Animator {
    
    static func animateTextColorChangingOnLabel(_ label: UILabel, to newTextColor: UIColor, duration: TimeInterval) {
        UIView.transition(with: label,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {
                            label.textColor = newTextColor
                          },
                          completion: nil)
    }
}
