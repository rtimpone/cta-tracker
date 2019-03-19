//
//  SelectStopsTableViewController.swift
//  CTATracker
//
//  Created by Rob Timpone on 3/15/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CTAKit
import UIKit

protocol SelectStopsTableViewControllerDelegate: class {
    func stopIsSelected(_ stop: Stop) -> Bool
    func didSelectStop(_ stop: Stop)
}

class SelectStopsTableViewController: UITableViewController {
    
    weak var delegate: SelectStopsTableViewControllerDelegate?
    var stations: [Station] = []
    
    func displayStations(_ stations: [Station]) {
        self.stations = stations
        refreshStations()
    }
    
    func refreshStations() {
        tableView.reloadData()
    }
    
    // MARK: Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let station = stations[indexPath.row]
        let cell = tableView.dequeueReusableCell(ofType: StationCell.self)
        let isSelected = delegate?.stopIsSelected(station) ?? false
        cell.configure(for: station, isSelected: isSelected)
        return cell
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let station = stations[indexPath.row]
        delegate?.didSelectStop(station)
    }
}
