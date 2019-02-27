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
    
    var stop: Stop!
    var etas: [ETA] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 50
    }
    
    func setEtas(_ etas: [ETA], for stop: Stop) {
        self.etas = etas
        self.stop = stop
    }
    
    func reloadEtas() {
        tableView.reloadData()
    }
    
    // MARK: Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return etas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let eta = etas[indexPath.row]
        let cell = tableView.dequeueReusableCell(ofType: EtaCell.self)
        cell.configure(for: eta)
        return cell
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeader(ofType: StationSectionHeader.self)
        header.configure(withText: stop.name)
        return header
    }
}
