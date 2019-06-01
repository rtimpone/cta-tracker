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
    @IBOutlet weak var checkmarkImageView: UIImageView!
    @IBOutlet weak var separatorView: UIView!
    
    func configure(for route: Route, isSelected: Bool, theme: Theme) {
        
        contentView.backgroundColor = theme.cellTheme.backgroundColor
        routeTitleLabel.textColor = theme.cellTheme.titleLabelColor
        separatorView.backgroundColor = theme.cellTheme.separatorColor
        checkmarkImageView.tintColor = theme.cellTheme.selectionIconColor
        
        routeColorView.backgroundColor = route.color
        routeTitleLabel.text = route.title
        checkmarkImageView.isHidden = !isSelected
    }
}
