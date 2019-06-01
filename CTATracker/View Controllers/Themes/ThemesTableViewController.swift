//
//  ThemesTableViewController.swift
//  CTATracker
//
//  Created by Rob Timpone on 5/27/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import UIKit

protocol ThemesTableViewControllerDelegate: class {
    func didSelectTheme(_ theme: Theme)
}

class ThemesTableViewController: ThemeableTableViewController {
    
    weak var delegate: ThemesTableViewControllerDelegate?
    let themes = Theme.allThemes
    
    // MARK: Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let themeOption = themes[indexPath.row]
        let cell = tableView.dequeueReusableCell(ofType: ThemeCell.self)
        cell.configure(for: themeOption, currentTheme: currentTheme)
        return cell
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let theme = themes[indexPath.row]
        delegate?.didSelectTheme(theme)
    }
}
