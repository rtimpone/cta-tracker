//
//  ThemeableTableViewController.swift
//  CTATracker
//
//  Created by Rob Timpone on 6/1/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import UIKit

class ThemeableTableViewController: UITableViewController {
    
    var currentTheme: Theme!
}

extension ThemeableTableViewController: Themeable {
    
    func applyTheme(_ theme: Theme) {
        currentTheme = theme
        tableView.separatorColor = theme.cellTheme.separatorColor
        tableView.reloadData()
    }
}
