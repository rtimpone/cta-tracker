//
//  ThemesViewController.swift
//  CTATracker
//
//  Created by Rob Timpone on 5/27/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import UIKit

protocol ThemesViewControllerDelegate: class {
    func themeDidChange(to theme: Theme)
}

class ThemesViewController: UIViewController {
    
    weak var delegate: ThemesViewControllerDelegate?
    weak var tableViewController: ThemesTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyCurrentTheme()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let vc = segue.destination as? ThemesTableViewController {
            tableViewController = vc
            vc.delegate = self
        }
    }
}

extension ThemesViewController: ThemesTableViewControllerDelegate {
    
    func didSelectTheme(_ theme: Theme) {

        guard theme != ThemeManager.currentTheme() else {
            return
        }
        
        ThemeManager.setCurrentTheme(theme)
        delegate?.themeDidChange(to: theme)
        
        Animator.animateChangesInView(view, duration: 0.5) {
            self.applyTheme(theme)
        }
    }
}

extension ThemesViewController: Themeable {
    
    func applyTheme(_ theme: Theme) {
        view.backgroundColor = theme.backgroundTheme.backgroundColor
        tableViewController?.applyTheme(theme)
    }
}
