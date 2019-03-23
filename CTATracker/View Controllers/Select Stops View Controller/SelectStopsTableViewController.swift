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
    var stops: [Stop] = []
    
    func displayStations(_ stations: [Station]) {
        var stops: [Stop] = []
        for station in stations {
            stops.append(station)
            stops.append(contentsOf: station.platforms)
        }
        self.stops = stops
        refreshStops()
    }
    
    func refreshStops() {
        tableView.reloadData()
    }
    
    // MARK: Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stops.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stop = stops[indexPath.row]
        let isSelected = delegate?.stopIsSelected(stop) ?? false
        return configuredCell(forStop: stop, isSelected: isSelected)
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stop = stops[indexPath.row]
        delegate?.didSelectStop(stop)
    }
}

private extension SelectStopsTableViewController {
    
    func configuredCell(forStop stop: Stop, isSelected: Bool) -> UITableViewCell {
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
            fatalError("Invalid stop found in data source: \(stop)")
        }
    }
}
