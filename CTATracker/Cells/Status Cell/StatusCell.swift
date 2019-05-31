//
//  StatusCell.swift
//  CTATracker
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import CTAKit
import UIKit

class StatusCell: UITableViewCell {
    
    @IBOutlet weak var routeColorView: UIView!
    @IBOutlet weak var routeTitleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var alertView: AlertView!
    
    func configure(for status: RouteStatus, theme: Theme) {
        
        backgroundColor = theme.cellTheme.backgroundColor
        
        routeColorView.backgroundColor = status.route.color
        routeTitleLabel.text = status.route.title
        routeTitleLabel.textColor = theme.cellTheme.titleLabelColor

        let severeAlerts = status.alerts.filter({ $0.isSevere })
        let mostSevereAlert = severeAlerts.sorted(by: { $0.severity > $1.severity }).first
        
        if let alert = mostSevereAlert {
            alertView.isHidden = false
            alertView.updateLabels(for: alert)
            alertView.updateHeightConstraintForVisisble()
            statusLabel.textColor = .red
            statusLabel.text = alert.impact
        }
        else {
            alertView.isHidden = true
            alertView.updateHeightConstraintForHidden()
            statusLabel.textColor = theme.cellTheme.detailLabelColor
            statusLabel.text = "Normal Service"
        }
    }
}
