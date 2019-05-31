//
//  SettingsViewController.swift
//  CTATracker
//
//  Created by Rob Timpone on 5/27/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate: class {
    func themeDidChange(to theme: Theme)
}

class SettingsViewController: UIViewController {
    
    weak var delegate: SettingsViewControllerDelegate?
    weak var tableViewController: SettingsTableViewController?
    
    static func instantiateNavigationControllerWithSettingsViewController(delegate: SettingsViewControllerDelegate) -> UINavigationController {
        let vc = SettingsViewController.instantiateFromStoryboard()
        vc.delegate = delegate
        let nvc = ThemeableNavigationViewController(rootViewController: vc)
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
        delegate?.themeDidChange(to: theme)
    }
}

extension SettingsViewController: Themeable {
    
    func applyTheme(_ theme: Theme) {
        view.backgroundColor = theme.backgroundTheme.backgroundColor
        tableViewController?.applyTheme(theme)
        if let nvc = navigationController as? ThemeableNavigationViewController {
            nvc.applyTheme(theme)
        }
    }
}
