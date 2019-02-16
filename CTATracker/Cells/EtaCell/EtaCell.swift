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
    
    func configure(for eta: ETA) {
        circleView.backgroundColor = eta.route.color
        destinationLabel.text = eta.destination
        etaLabel.text = EtaDescriptionGenerator.string(for: eta)
    }
}
