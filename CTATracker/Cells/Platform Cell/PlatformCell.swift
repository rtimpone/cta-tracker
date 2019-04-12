//
//  PlatformCell.swift
//  CTATracker
//
//  Created by Rob Timpone on 3/19/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CTAKit
import UIKit

class PlatformCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var selectedLabel: UILabel!
    @IBOutlet weak var colorsView: RouteColorsView!
    @IBOutlet weak var colorsViewWidthConstraint: NSLayoutConstraint!
    
    func configure(for platform: Platform, isSelected: Bool) {
        
        nameLabel.text = platform.name
        selectedLabel.isHidden = !isSelected
        colorsView.showColors(forRoutes: platform.routes)
        colorsViewWidthConstraint.constant = colorsView.widthForNumberOfRoutes(platform.routes.count)
    }
}

class RouteColorsView: UIView {
    
    @IBOutlet weak var colorView1: UIView!
    @IBOutlet weak var colorView2: UIView!
    @IBOutlet weak var colorView3: UIView!
    @IBOutlet weak var colorView4: UIView!
    
    var colorViews: [UIView] {
        return [colorView1, colorView2, colorView3, colorView4]
    }
    
    func showColors(forRoutes routes: [Route]) {
        
        var numberOfViewsPopulated = 0
        for (index, route) in routes.enumerated() {
            let view = colorViews[index]
            view.backgroundColor = route.color
            view.isHidden = false
            numberOfViewsPopulated += 1
        }

        let firstIndexToHide = numberOfViewsPopulated
        hideColorViewsStartingAtIndex(firstIndexToHide)
    }
    
    func widthForNumberOfRoutes(_ routesCount: Int) -> CGFloat {
        
        let colorViewWidth = 20
        let spacingBetweenColorViewsWidth = 8
        
        let numberOfColorViewsToShow = routesCount
        let numberOfSpacers = routesCount - 1
        
        let width = (numberOfColorViewsToShow * colorViewWidth) + (numberOfSpacers * spacingBetweenColorViewsWidth)
        return CGFloat(width)
    }
}

private extension RouteColorsView {
    
    func hideColorViewsStartingAtIndex(_ firstIndexToHide: Int) {
        let indicesToHide = firstIndexToHide..<colorViews.count
        for index in indicesToHide {
            let view = colorViews[index]
            view.isHidden = true
        }
    }
}
