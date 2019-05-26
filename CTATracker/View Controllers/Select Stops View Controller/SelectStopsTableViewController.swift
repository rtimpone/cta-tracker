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
    
    struct Section {
        var stops: [Stop]
    }
    
    weak var delegate: SelectStopsTableViewControllerDelegate?
    var sections: [Section] = []
    var sectionIndexTitlesToSectionNumbers: [String: Int] = [:]
    
    let sectionIndexTitles = ["#", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    func displayStations(_ stations: [Station]) {
        
        let sortedStations = stations.sorted(by: { $0.name < $1.name })
        var sectionIndexTitlesRecorded: Set<String> = []
        
        for (index, station) in sortedStations.enumerated() {
            
            var stops: [Stop] = []
            stops.append(station)
            let platforms = sortedPlatforms(for: station)
            stops.append(contentsOf: platforms)
            
            let section = Section(stops: stops)
            sections.append(section)
            
            let firstCharacterOfStationName = String(station.name.prefix(1))
            let isNumber = Int(firstCharacterOfStationName) != nil
            let sectionIndexTitle = isNumber ? "#" : firstCharacterOfStationName
            let isFirstSectionForIndexTitle = !sectionIndexTitlesRecorded.contains(sectionIndexTitle)
            
            if isFirstSectionForIndexTitle {
                sectionIndexTitlesToSectionNumbers[sectionIndexTitle] = index
                sectionIndexTitlesRecorded.insert(sectionIndexTitle)
            }
        }
        
        for (index, sectionIndexTitle) in sectionIndexTitles.enumerated() {
            if sectionIndexTitlesToSectionNumbers[sectionIndexTitle] == nil {
                
                var sectionNumberAssigned = false
                
                for forwardIndex in (index + 1)..<sectionIndexTitles.count {
                    let forwardTitle = sectionIndexTitles[forwardIndex]
                    if let sectionNumber = sectionIndexTitlesToSectionNumbers[forwardTitle] {
                        sectionIndexTitlesToSectionNumbers[sectionIndexTitle] = sectionNumber
                        sectionNumberAssigned = true
                        break
                    }
                }
                
                guard !sectionNumberAssigned else {
                    continue
                }
                
                for backwardsIndex in (0..<index).reversed() {
                    let backwardsTitle = sectionIndexTitles[backwardsIndex]
                    if let sectionNumber = sectionIndexTitlesToSectionNumbers[backwardsTitle] {
                        sectionIndexTitlesToSectionNumbers[sectionIndexTitle] = sectionNumber
                        break
                    }
                }
            }
        }
        
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
        let isSelected = delegate?.stopIsSelected(stop) ?? false
        return configuredCell(forStop: stop, isSelected: isSelected)
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionIndexTitles
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return sectionIndexTitlesToSectionNumbers[title] ?? 0
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stop = stopAtIndexPath(indexPath)
        delegate?.didSelectStop(stop)
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
