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
    
    func configure(for arrivals: [TrainArrival]) {
        
        guard arrivals.count > 0 else {
            firstArrivalView.clearTextInLabels()
            secondArrivalView.clearTextInLabels()
            thirdArrivalView.clearTextInLabels()
            fourthArrivalView.clearTextInLabels()
            return
        }
        
        let firstArrival = arrivals[0]
        destinationLabel.text = firstArrival.stationName
        firstArrivalView.configure(for: firstArrival)
        
        guard arrivals.count > 1 else {
            secondArrivalView.clearTextInLabels()
            thirdArrivalView.clearTextInLabels()
            fourthArrivalView.clearTextInLabels()
            return
        }
        
        secondArrivalView.configure(for: arrivals[1])
        
        guard arrivals.count > 2 else {
            thirdArrivalView.clearTextInLabels()
            fourthArrivalView.clearTextInLabels()
            return
        }
        
        thirdArrivalView.configure(for: arrivals[2])
        
        guard arrivals.count > 3 else {
            fourthArrivalView.clearTextInLabels()
            return
        }
        
        fourthArrivalView.configure(for: arrivals[3])
    }
}

class ArrivalView: UIView {
    
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var etaLabel: UILabel!
    
    func configure(for arrival: TrainArrival) {
        destinationLabel.text = arrival.destination
        
        let now = Date()
        let secondsUntilArrival = arrival.arrivalTime.timeIntervalSince(now)
        etaLabel.text = "\(secondsUntilArrival)s"
    }
    
    func clearTextInLabels() {
        destinationLabel.text = ""
        etaLabel.text = ""
    }
}
