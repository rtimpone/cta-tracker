//
//  RouteCell.swift
//  CTATracker
//
//  Created by Rob Timpone on 3/16/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CTAKit
import UIKit

class RouteCell: UITableViewCell {

    @IBOutlet weak var routeColorView: UIView!
    @IBOutlet weak var routeTitleLabel: UILabel!
    @IBOutlet weak var selectedLabel: UILabel!
    
    func configure(for route: Route, isSelected: Bool) {
        routeColorView.backgroundColor = route.color
        routeTitleLabel.text = route.title
        selectedLabel.isHidden = !isSelected
    }
}
