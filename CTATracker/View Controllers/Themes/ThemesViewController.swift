//
//  ThemesViewController.swift
//  CTATracker
//
//  Created by Rob Timpone on 5/27/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import UIKit

class ThemesViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let vc = segue.destination as? ThemesTableViewController {
            vc.delegate = self
        }
    }
}

extension ThemesViewController: ThemesTableViewControllerDelegate {
    
    func didSelectTheme(_ theme: Theme) {
        print(theme)
        
        //write theme to user defaults
        
        //apply theme to current and all visible vc's
    }
}
