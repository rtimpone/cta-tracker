//
//  ConstraintFactory.swift
//  CTATracker
//
//  Created by Rob Timpone on 1/19/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import UIKit

struct ConstraintFactory {
    
    static func heightConstraint(for view: Any, _ relation: NSLayoutConstraint.Relation, to constant: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view,
                                  attribute: .height,
                                  relatedBy: relation,
                                  toItem: nil,
                                  attribute: .notAnAttribute,
                                  multiplier: 1,
                                  constant: constant)
    }
}
