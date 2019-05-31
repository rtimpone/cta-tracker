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
    @IBOutlet weak var locationIcon: UIImageView!
    @IBOutlet weak var emptyStateLabel: UILabel!
    
    var locationIconOriginalWidthValue: CGFloat = 0
    @IBOutlet weak var locationIconWidthConstraint: NSLayoutConstraint! {
        didSet {
            if locationIconOriginalWidthValue == 0 {
                locationIconOriginalWidthValue = locationIconWidthConstraint.constant
            }
        }
    }
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        locationIcon.tintColor = Colors.darkGray
    }

    func configure(for arrivals: StopArrivals, isLocationBased: Bool, theme: Theme) {
        
        backgroundColor = theme.cellTheme.backgroundColor
        contentView.backgroundColor = theme.cellTheme.backgroundColor
        destinationLabel.textColor = theme.cellTheme.titleLabelColor
        emptyStateLabel.textColor = theme.cellTheme.detailLabelColor
        
        destinationLabel.text = arrivals.stop.name
        emptyStateLabel.isHidden = !arrivals.etas.isEmpty
        
        locationIcon.isHidden = !isLocationBased
        locationIconWidthConstraint.constant = isLocationBased ? locationIconOriginalWidthValue : 0
        
        bottomConstraint?.isActive = false
        
        let etas = arrivals.etas
        for (index, view) in arrivalViews.enumerated() {
            
            if index < etas.count {
                
                view.isHidden = false
                
                let eta = etas[index]
                view.configure(for: eta, theme: theme)
                
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
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var etaLabel: UILabel!
    
    func configure(for eta: ETA, theme: Theme) {
        
        backgroundColor = theme.cellTheme.backgroundColor
        destinationLabel.textColor = theme.cellTheme.detailLabelColor
        etaLabel.textColor = theme.cellTheme.detailLabelColor
        
        circleView.backgroundColor = eta.route.color
        circleView.isHidden = false
        destinationLabel.text = eta.destination
        
        switch eta.status {
        case .scheduled:
            iconImageView.image = Images.clock
        case .delayed:
            iconImageView.image = Images.error
        case .enRoute, .approaching, .unavailable:
            iconImageView.image = nil
        }
        
        etaLabel.text = ArrivalDescriptionGenerator.string(for: eta.status, secondsUntilArrival: eta.secondsUntilArrival)
    }
}
