//
//  ArrivalCell.swift
//  CTATracker
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import CTAKit
import UIKit

class ArrivalCell: UITableViewCell, NibBased {
    
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var firstArrivalView: ArrivalView!
    @IBOutlet weak var secondArrivalView: ArrivalView!
    @IBOutlet weak var thirdArrivalView: ArrivalView!
    @IBOutlet weak var fourthArrivalView: ArrivalView!
    
    func configure(for arrivals: StationArrivals) {
        
        let etas = arrivals.etas
        
        guard etas.count > 0 else {
            firstArrivalView.clearTextInLabels()
            secondArrivalView.clearTextInLabels()
            thirdArrivalView.clearTextInLabels()
            fourthArrivalView.clearTextInLabels()
            return
        }
        
        destinationLabel.text = arrivals.station.name
        firstArrivalView.configure(for: etas[0])
        
        guard etas.count > 1 else {
            secondArrivalView.clearTextInLabels()
            thirdArrivalView.clearTextInLabels()
            fourthArrivalView.clearTextInLabels()
            return
        }
        
        secondArrivalView.configure(for: etas[1])
        
        guard etas.count > 2 else {
            thirdArrivalView.clearTextInLabels()
            fourthArrivalView.clearTextInLabels()
            return
        }
        
        thirdArrivalView.configure(for: etas[2])
        
        guard etas.count > 3 else {
            fourthArrivalView.clearTextInLabels()
            return
        }
        
        fourthArrivalView.configure(for: etas[3])
    }
}

class ArrivalView: UIView {
    
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var etaLabel: UILabel!
    
    func configure(for eta: ETA) {
        circleView.backgroundColor = eta.route.color
        destinationLabel.text = eta.destination
        etaLabel.text = ArrivalDescriptionGenerator.string(for: eta.status)
    }
    
    func clearTextInLabels() {
        destinationLabel.text = ""
        etaLabel.text = ""
    }
}

class ArrivalDescriptionGenerator {
    
    static func string(for status: ArrivalStatus) -> String {
        switch status {
        case .enRoute(let seconds), .scheduled(let seconds):
            if seconds < 0 {
                return "Overdue"
            }
            else if seconds < 60 {
                return "Due"
            }
            else if seconds > 30 * 60 {
                return "Over 30 min"
            }
            else {
                return minutesStringForNumberOfSecondsRoundingUp(seconds)
            }
        case .approaching:
            return "Approaching"
        case .delayed:
            return "Delayed"
        case .unavailable:
            return "Unavailable"
        }
    }
}

private extension ArrivalDescriptionGenerator {
    
    static func minutesStringForNumberOfSecondsRoundingUp(_ seconds: Int) -> String {
        let minutesPassed = seconds / 60
        let secondsRemaining = seconds % 60
        let shouldRoundUp = secondsRemaining > 0
        let minutes = shouldRoundUp ? (minutesPassed + 1) : minutesPassed
        return "\(minutes) min"
    }
}

