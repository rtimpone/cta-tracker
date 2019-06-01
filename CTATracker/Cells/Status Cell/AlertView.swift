//
//  AlertView.swift
//  CTATracker
//
//  Created by Rob Timpone on 1/19/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CTAKit
import UIKit

class AlertView: UIView {
    
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var heightConstraint: NSLayoutConstraint?
    
    func updateLabels(for alert: Alert) {
        headlineLabel.text = alert.headline
        descriptionLabel.text = alert.message
    }
    
    func updateHeightConstraintForVisisble() {
        let newConstraint = ConstraintFactory.heightConstraint(for: self, .greaterThanOrEqual, to: 67.5)
        changeHeightConstraint(to: newConstraint)
    }
    
    func updateHeightConstraintForHidden() {
        let newConstraint = ConstraintFactory.heightConstraint(for: self, .equal, to: 0)
        changeHeightConstraint(to: newConstraint)
    }
}

extension AlertView: Themeable {
    
    func applyTheme(_ theme: Theme) {
        headlineLabel.textColor = theme.cellTheme.detailLabelColor
        descriptionLabel.textColor = theme.cellTheme.detailLabelColor
    }
}

private extension AlertView {
    
    func changeHeightConstraint(to newConstraint: NSLayoutConstraint) {
        heightConstraint?.isActive = false
        newConstraint.isActive = true
        heightConstraint = newConstraint
    }
}
