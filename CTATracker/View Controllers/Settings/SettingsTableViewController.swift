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
