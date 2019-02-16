//
//  ArrivalCell.swift
//  CTATracker
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import CTAKit
import UIKit

class ArrivalCell: UITableViewCell {
    
    @IBOutlet weak var destinationLabel: UILabel!
    
    @IBOutlet weak var firstArrivalView: ArrivalView!
    @IBOutlet weak var secondArrivalView: ArrivalView!
    @IBOutlet weak var thirdArrivalView: ArrivalView!
    @IBOutlet weak var fourthArrivalView: ArrivalView!
    @IBOutlet weak var fifthArrivalView: ArrivalView!
    @IBOutlet weak var sixthArrivalView: ArrivalView!
    
    var arrivalViews: [ArrivalView] {
        return [firstArrivalView, secondArrivalView, thirdArrivalView, fourthArrivalView, fifthArrivalView, sixthArrivalView]
    }
    
    var bottomConstraint: NSLayoutConstraint?

    func configure(for arrivals: StopArrivals) {
        
        destinationLabel.text = arrivals.stop.name
        
        bottomConstraint?.isActive = false
        
        let etas = arrivals.etas
        for (index, view) in arrivalViews.enumerated() {
            
            if index < etas.count {
                
                view.isHidden = false
                
                let eta = etas[index]
                view.configure(for: eta)
                
                let isLastEtaAvailable = index == etas.count - 1
                let isLastViewAvailable = index == arrivalViews.count - 1
                
                if isLastEtaAvailable || isLastViewAvailable {
                    bottomConstraint = constraintFromBottomOfCellContentView(toBottomOfView: view)
                    bottomConstraint?.isActive = true
                }
            }
            else {
                view.isHidden = true
            }
        }
    }
    
    func constraintFromBottomOfCellContentView(toBottomOfView view: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 16.5)
    }
}

class ArrivalView: UIView {
    
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var etaLabel: UILabel!
    
    func configure(for eta: ETA) {
        circleView.backgroundColor = eta.route.color
        circleView.isHidden = false
        destinationLabel.text = eta.destination
        etaLabel.text = ArrivalDescriptionGenerator.string(for: eta.status)
    }
}
