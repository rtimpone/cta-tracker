//
//  SettingsViewController.swift
//  CTATracker
//
//  Created by Rob Timpone on 5/27/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    weak var tableViewController: SettingsTableViewController?
    
    static func instantiateNavigationControllerWithSettingsViewController() -> UINavigationController {
        let vc = SettingsViewController.instantiateFromStoryboard()
        let nvc = UINavigationController(rootViewController: vc)
        nvc.navigationBar.tintColor = Colors.darkGray
        return nvc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyCurrentTheme()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let vc = segue.destination as? SettingsTableViewController {
            tableViewController = vc
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
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SettingsViewController: ThemesViewControllerDelegate {
    
    func themeDidChange(to theme: Theme) {
        applyTheme(theme)
    }
}

extension SettingsViewController: Themeable {
    
    func applyTheme(_ theme: Theme) {
        
        guard let navBar = navigationController?.navigationBar else {
            return
        }
        
        view.backgroundColor = theme.backgroundTheme.backgroundColor
        
        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: theme.navBarTheme.titleColor]
        navBar.tintColor = theme.navBarTheme.buttonColor
        navBar.barTintColor = theme.navBarTheme.backgroundColor
        
        tableViewController?.applyTheme(theme)
    }
}
