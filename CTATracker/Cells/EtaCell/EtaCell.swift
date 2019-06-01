//
//  EtaCell.swift
//  CTATracker
//
//  Created by Rob Timpone on 2/16/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CTAKit
import UIKit

class EtaCell: UITableViewCell {

    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var etaLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    func highlightEtaLabel() {
        Animator.animateTextColorChangingOnLabel(etaLabel, to: .blue, duration: 0.5)
    }
    
    func configure(for eta: ETA, theme: Theme) {
        
        destinationLabel.textColor = theme.cellTheme.titleLabelColor
        etaLabel.textColor = theme.cellTheme.detailLabelColor
        
        circleView.backgroundColor = eta.route.color
        destinationLabel.text = eta.destination
        etaLabel.text = EtaDescriptionGenerator.stringForTrainArrivingInSeconds(eta.secondsUntilArrival)
        
        switch eta.status {
        case .delayed:
            infoLabel.text = "Delayed"
            infoLabel.textColor = .red
        case .scheduled:
            infoLabel.text = "Scheduled"
            infoLabel.textColor = theme.cellTheme.placeholderLabelColor
        case .approaching, .enRoute, .unavailable:
            infoLabel.text = ""
            infoLabel.textColor = theme.cellTheme.detailLabelColor
        }
    }
}
