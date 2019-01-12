//
//  StatusCell.swift
//  CTATracker
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import CTAKit
import UIKit

class StatusCell: UITableViewCell, NibBased {
    
    @IBOutlet weak var lineColorView: UIView!
    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    func configure(for line: TrainLine) {
        
        lineColorView.backgroundColor = line.displayColor
        lineLabel.text = line.title
        statusLabel.text = line.status.rawValue
        statusLabel.textColor = color(forStatus: line.status)
    }
}

private extension StatusCell {
    
    func color(forStatus status: TrainLine.LineStatus) -> UIColor {
        switch status {
        case .normal, .specialNote, .serviceChange:
            return .black
        case .minorDelays, .majorDelays, .significantDelays, .serviceDisruption:
            return .red
        case .unknown:
            return .lightGray
        }
    }
}
