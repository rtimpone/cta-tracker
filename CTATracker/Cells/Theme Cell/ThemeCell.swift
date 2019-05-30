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
    @IBOutlet weak var separatorView: UIView!
    
    func configure(for theme: Theme) {
        nameLabel.text = theme.name
    }
}

extension ThemeCell: Themeable {
    
    func applyTheme(_ theme: Theme) {
        backgroundColor = theme.cellTheme.backgroundColor
        nameLabel.textColor = theme.cellTheme.titleLabelColor
        separatorView.backgroundColor = theme.cellTheme.separatorColor
    }
}
