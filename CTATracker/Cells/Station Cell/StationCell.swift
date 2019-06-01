//
//  StationCell.swift
//  CTATracker
//
//  Created by Rob Timpone on 3/19/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CTAKit
import UIKit

class StationCell: UITableViewCell {

    @IBOutlet weak var stationTitleLabel: UILabel!
    @IBOutlet weak var checkmarkImageView: UIImageView!
    
    func configure(for station: Station, isSelected: Bool) {
        stationTitleLabel.text = station.name
        checkmarkImageView.isHidden = !isSelected
    }
}
