//
//  SelectSingleStopViewController.swift
//  CTATracker
//
//  Created by Rob Timpone on 5/26/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CTAKit
import UIKit

class SelectSingleStopViewController: UIViewController {
    
    var currentTheme: Theme!
    var statusBarStyle: UIStatusBarStyle = .default
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        //have to explicitly give a status bar style here because definesPresentationContext is set to true
        //not setting this will revert it back to the default when we pop back from the station vc
        return statusBarStyle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting this to true prevents a weird bug where the nav bar is missing when the station vc is pushed onto the nav stack
        definesPresentationContext = true
        
        applyCurrentTheme()
        let vc = SelectStopsViewController.instance(withDelegate: self)
        add(child: vc)
    }
}
    
extension SelectSingleStopViewController: SelectStopsViewControllerDelegate {
    
    func cellForStop(_ stop: Stop, in tableView: UITableView) -> UITableViewCell {
        let isSelected = false
        if let station = stop as? Station {
            let cell = tableView.dequeueReusableCell(ofType: StationCell.self)
            cell.configure(for: station, isSelected: isSelected, theme: currentTheme)
            return cell
        }
        else if let platform = stop as? Platform {
            let cell = tableView.dequeueReusableCell(ofType: PlatformCell.self)
            cell.configure(for: platform, isSelected: isSelected, theme: currentTheme)
            return cell
        }
        else {
            fatalError("Stop is not a station or a platform")
        }
    }
    
    func didSelectStop(_ stop: Stop) {
        
        if let searchBar = navigationItem.searchController?.searchBar {
            searchBar.resignFirstResponder()
        }
        
        let svc = StationViewController.instance(for: stop)
        navigationController?.pushViewController(svc, animated: true)
    }
}

extension SelectSingleStopViewController: Themeable {
    
    func applyTheme(_ theme: Theme) {
        currentTheme = theme
        statusBarStyle = theme.statusBarTheme.style
        setNeedsStatusBarAppearanceUpdate()
    }
}
