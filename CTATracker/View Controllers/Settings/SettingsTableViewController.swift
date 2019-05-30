//
//  SettingsTableViewController.swift
//  CTATracker
//
//  Created by Rob Timpone on 5/27/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import UIKit

protocol SettingsTableViewControllerDelegate: class {
    func didSelectThemes()
}

class SettingsTableViewController: UITableViewController {
    
    enum Section {
        case themes
        case support
        case about
    }
    
    @IBOutlet weak var headerSeparatorView: UIView!
    
    @IBOutlet weak var themesCell: UITableViewCell!
    @IBOutlet weak var supportCell: UITableViewCell!
    @IBOutlet weak var aboutCell: UITableViewCell!
    
    @IBOutlet weak var themesLabel: UILabel!
    @IBOutlet weak var supportLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    
    @IBOutlet weak var themesSeparator: UIView!
    @IBOutlet weak var supportSeparator: UIView!
    @IBOutlet weak var aboutSeparator: UIView!
    
    weak var delegate: SettingsTableViewControllerDelegate?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch sectionForIndexPath(indexPath) {
        case .themes:
            delegate?.didSelectThemes()
        case .support:
            print("Did select support")
        case .about:
            print("Did select about")
        }
    }
}

extension SettingsTableViewController: Themeable {
    
    func applyTheme(_ theme: Theme) {
        
        tableView.backgroundColor = theme.tableTheme.backgroundColor
        
        let cellColor = theme.cellTheme.backgroundColor
        themesCell.backgroundColor = cellColor
        supportCell.backgroundColor = cellColor
        aboutCell.backgroundColor = cellColor
        
        let textColor = theme.cellTheme.titleLabelColor
        themesLabel.textColor = textColor
        supportLabel.textColor = textColor
        aboutLabel.textColor = textColor
        
        let separatorColor = theme.cellTheme.separatorColor
        themesSeparator.backgroundColor = separatorColor
        supportSeparator.backgroundColor = separatorColor
        aboutSeparator.backgroundColor = separatorColor
        headerSeparatorView.backgroundColor = separatorColor
    }
}

private extension SettingsTableViewController {
    
    func sectionForIndexPath(_ indexPath: IndexPath) -> Section {
        switch indexPath.row {
        case 0:
            return .themes
        case 1:
            return .support
        case 2:
            return .about
        default:
            fatalError("Unsupported index path")
        }
    }
}
