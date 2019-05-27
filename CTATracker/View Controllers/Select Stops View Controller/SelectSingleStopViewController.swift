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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = SelectStopsViewController.instance(withDelegate: self)
        add(child: vc)
    }
}
    
extension SelectSingleStopViewController: SelectStopsViewControllerDelegate {
    
    func cellForStop(_ stop: Stop, in tableView: UITableView) -> UITableViewCell {
        let isSelected = false
        if let station = stop as? Station {
            let cell = tableView.dequeueReusableCell(ofType: StationCell.self)
            cell.configure(for: station, isSelected: isSelected)
            return cell
        }
        else if let platform = stop as? Platform {
            let cell = tableView.dequeueReusableCell(ofType: PlatformCell.self)
            cell.configure(for: platform, isSelected: isSelected)
            return cell
        }
        else {
            fatalError("Stop is not a station or a platform")
        }
    }
    
    func didSelectStop(_ stop: Stop) {
        let svc = StationViewController.instance(for: stop)
        self.navigationController?.pushViewController(svc, animated: true)
    }
}
