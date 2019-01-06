//
//  RootViewController.swift
//  CTATracker
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import CTAKit
import UIKit

class RootViewController: UIViewController {
    
    let locationHandler = LocationHandler()
    let arrivalsRequestHandler = ArrivalsRequestHandler()
    let statusRequestHandler = StatusRequestHandler()
    
    weak var tableViewController: TableViewController!
    var currentDeviceCoordinate: Coordinate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let permissionStatus = locationHandler.fetchCurrentPermissionStatus()
        switch permissionStatus {
        case .granted:
            makeRequestsWithLocationPermission()
        case .denied:
            makeRequestsWithoutLocationPermission()
        case .notYetRequested:
            locationHandler.requestLocationPermission() { [weak self] permissionGranted in
                if permissionGranted {
                    self?.makeRequestsWithLocationPermission()
                }
                else {
                    self?.makeRequestsWithoutLocationPermission()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? TableViewController {
            vc.delegate = self
            tableViewController = vc
        }
    }
    
    func getCurrentLocation(completion: @escaping () -> Void) {
        locationHandler.fetchCurrentLocation() { coordinate in
            self.currentDeviceCoordinate = coordinate
            completion()
        }
    }
    
    func makeInitialNetworkRequests() {
        UTCOffsets.lookupOffsets {
            self.refreshDataFromApi()
        }
    }
}

extension RootViewController: TableViewDelegate {
    
    func refreshControlWasActivated() {
        refreshDataFromApi()
    }
}

private extension RootViewController {
    
    func makeRequestsWithLocationPermission() {
        getCurrentLocation {
            UTCOffsets.lookupOffsets {
                self.refreshDataFromApi()
            }
        }
    }
    
    func makeRequestsWithoutLocationPermission() {
        UTCOffsets.lookupOffsets {
            self.refreshDataFromApi()
        }
    }
    
    func refreshDataFromApi() {
        
        //refresh control
        
        statusRequestHandler.requestTrainStatus() { result in
            switch result {
            case .success(let lines):
                self.tableViewController.displayTrainLines(lines)
            case .error:
                self.tableViewController.displayTrainLinesError()
            }
        }
        
        arrivalsRequestHandler.requestTrainStopArrivalTimes() { result in
            switch result {
            case .success(let arrivals):
                var sortedArrivals = arrivals
                if let coordinate = self.currentDeviceCoordinate {
                    sortedArrivals = ArrivalsSorter.sortArrivals(arrivals, byDistanceTo: coordinate)
                }
                self.tableViewController.displayArrivals(sortedArrivals)
            case .error:
                self.tableViewController.displayArrivalsError()
            }
        }
    }
}
