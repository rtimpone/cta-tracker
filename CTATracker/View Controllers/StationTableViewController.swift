//
//  StationTableViewController.swift
//  CTATracker
//
//  Created by Rob Timpone on 2/16/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CTAKit
import UIKit

class StationTableViewController: UITableViewController {
    
    var etas: [ETA] = []
    
    func displayEtas(_ etas: [ETA]) {
        self.etas = etas
        tableView.reloadData()
    }
    
    // MARK: Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return etas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let eta = etas[indexPath.row]
        let cell =  UITableViewCell(style: .default, reuseIdentifier: "etaCell")
        cell.textLabel?.text = eta.destination
        return cell
    }
}
