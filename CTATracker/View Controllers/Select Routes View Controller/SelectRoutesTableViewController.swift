//
//  SelectRoutesTableViewController.swift
//  CTATracker
//
//  Created by Rob Timpone on 3/15/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CTAKit
import UIKit

protocol SelectRoutesTableViewControllerDelegate: class {
    func routeIsSelected(_ route: Route) -> Bool
}

class SelectRoutesTableViewController: UITableViewController {
    
    weak var delegate: SelectRoutesTableViewControllerDelegate?
    var routes: [Route] = []
    
    func displayRoutes(_ routes: [Route]) {
        self.routes = routes
        tableView.reloadData()
    }
    
    // MARK: Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let route = routes[indexPath.row]
        let cell = tableView.dequeueReusableCell(ofType: RouteCell.self)
        let isSelected = delegate?.routeIsSelected(route) ?? false
        cell.configure(for: route, isSelected: isSelected)
        return cell
    }
}
