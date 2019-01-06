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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let permissionStatus = locationHandler.fetchCurrentPermissionStatus()
        switch permissionStatus {
        case .granted:
            makeInitialApiRequests()
        case .denied:
            print("unable to sort by location")
        case .notYetRequested:
            locationHandler.requestLocationPermission() { [weak self] permissionWasGranted in
                if permissionWasGranted {
                    self?.makeInitialApiRequests()
                }
                else {
                    //hide sorting options for train stops
                }
            }
            makeInitialApiRequests()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? TableViewController {
            vc.delegate = self
            tableViewController = vc
        }
    }
    
    func makeInitialApiRequests() {
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
                self.tableViewController.displayArrivals(arrivals)
            case .error:
                self.tableViewController.displayArrivalsError()
            }
        }
    }
}
