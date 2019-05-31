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
    var currentTheme: Theme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 50
    }
    
    func setEtas(_ etas: [ETA], for stop: Stop) {
        self.etas = etas
        self.stop = stop
        for cell in tableView.visibleCells {
            if let etaCell = cell as? EtaCell {
                etaCell.highlightEtaLabel()
            }
        }
    }
    
    func reloadEtas() {
        tableView.reloadData()
    }
    
    // MARK: Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(etas.count, 1)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard etas.count > 0 else {
            let cell = tableView.dequeueReusableCell(ofType: GenericMessageCell.self)
            cell.configure(withText: "Getting arrivals data for this station...", theme: currentTheme)
            return cell
        }
        
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
