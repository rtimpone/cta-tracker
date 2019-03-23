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
    
    func configure(for platform: Platform, isSelected: Bool) {
        nameLabel.text = platform.name
        selectedLabel.isHidden = !isSelected
        colorsView.showColors(forRoutes: platform.routes)
    }
}

class RouteColorsView: UIView {
    
    @IBOutlet weak var colorView1: UIView!
    @IBOutlet weak var colorView2: UIView!
    @IBOutlet weak var colorView3: UIView!
    @IBOutlet weak var colorView4: UIView!
    @IBOutlet weak var colorView5: UIView!
    @IBOutlet weak var colorView6: UIView!
    @IBOutlet weak var colorView7: UIView!
    @IBOutlet weak var colorView8: UIView!
    @IBOutlet weak var colorView9: UIView!
    @IBOutlet weak var colorView10: UIView!
    
    var colorViews: [UIView] {
        return [colorView1, colorView2, colorView3, colorView4, colorView5, colorView6, colorView7, colorView8, colorView9, colorView10]
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
