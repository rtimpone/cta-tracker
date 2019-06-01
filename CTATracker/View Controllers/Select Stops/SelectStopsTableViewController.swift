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
    func cellForStop(_ stop: Stop, in tableView: UITableView) -> UITableViewCell
    func didSelectStop(_ stop: Stop)
}

class SelectStopsTableViewController: ThemeableTableViewController {
    
    struct Section {
        var stops: [Stop]
    }
    
    weak var delegate: SelectStopsTableViewControllerDelegate!
    var sections: [Section] = []
    var sectionIndexTitlesToSectionNumbers: [String: Int] = [:]
    
    func displayStations(_ stations: [Station]) {
        
        let sortedStations = stations.sorted(by: { $0.name < $1.name })
        var stationNames: [String] = []
        var newSections: [Section] = []
        
        for station in sortedStations {
            
            var stops: [Stop] = []
            stops.append(station)
            stationNames.append(station.name)
            
            let platforms = sortedPlatforms(for: station)
            stops.append(contentsOf: platforms)
            
            let section = Section(stops: stops)
            newSections.append(section)
        }
        
        sections = newSections
        sectionIndexTitlesToSectionNumbers = SectionIndexTitlesFactory.sectionIndexTitlesToSectionNumbersDictionary(forSortedStrings: stationNames)
        refreshStops()
    }
    
    func refreshStops() {
        tableView.reloadData()
    }
    
    // MARK: Table View Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].stops.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stop = stopAtIndexPath(indexPath)
        return delegate.cellForStop(stop, in: tableView)
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return SectionIndexTitlesFactory.sectionIndexTitles
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return sectionIndexTitlesToSectionNumbers[title] ?? 0
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stop = stopAtIndexPath(indexPath)
        delegate.didSelectStop(stop)
    }
}

private extension SelectStopsTableViewController {
    
    func stopAtIndexPath(_ indexPath: IndexPath) -> Stop {
        return sections[indexPath.section].stops[indexPath.row]
    }
    
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
            fatalError("Stop found in data source is neither a station nor a platform: \(stop)")
        }
    }
    
    func sortedPlatforms(for station: Station) -> [Platform] {
        return station.platforms.sorted(by: {
            guard let route0 = $0.routes.first, let route1 = $1.routes.first else {
                return false
            }
            if route0 == route1 {
                return $0.name < $1.name
            }
            else {
                return route0.title < route1.title
            }
        })
    }
}
