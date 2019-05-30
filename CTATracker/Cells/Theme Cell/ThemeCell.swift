//
//  ThemeCell.swift
//  CTATracker
//
//  Created by Rob Timpone on 5/27/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import UIKit

class ThemeCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func configure(for theme: Theme) {
        nameLabel.text = theme.name
    }
}
