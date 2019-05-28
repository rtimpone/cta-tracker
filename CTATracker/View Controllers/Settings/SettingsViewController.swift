//
//  SettingsViewController.swift
//  CTATracker
//
//  Created by Rob Timpone on 5/27/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    static func instantiateNavigationControllerWithSettingsViewController() -> UINavigationController {
        let vc = SettingsViewController.instantiateFromStoryboard()
        let nvc = UINavigationController(rootViewController: vc)
        nvc.navigationBar.tintColor = Colors.darkGray
        return nvc
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let vc = segue.destination as? SettingsTableViewController {
            vc.delegate = self
        }
        
    }
    
    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

extension SettingsViewController: SettingsTableViewControllerDelegate {
    
    func didSelectThemes() {
        let vc = ThemesViewController.instantiateFromStoryboard()
        navigationController?.pushViewController(vc, animated: true)
    }
}
