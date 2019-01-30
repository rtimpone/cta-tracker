//
//  RootViewController.swift
//  CTATracker
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import CTAKit
import SafariServices
import UIKit

class RootViewController: UIViewController {
    
    let locationHandler = LocationHandler()
    let arrivalsRequestHandler = ArrivalsRequestHandler()
    let statusRequestHandler = StatusRequestHandler()
    
    weak var tableViewController: TableViewController!
    var currentDeviceCoordinate: Coordinate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWillEnterForegroundNotificationSubscription()
        
        switch locationHandler.permissionStatus {
        case .granted:
            makeRequestsWithLocationPermission()
        case .denied:
            makeRequestsWithoutLocationPermission()
        case .notYetRequested:
            locationHandler.requestLocationPermission() { [weak self] in
                self?.refreshLocationAndTrainData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? TableViewController {
            vc.delegate = self
            tableViewController = vc
        }
    }
}

extension RootViewController: TableViewDelegate {
    
    func refreshControlWasActivated() {
        refreshLocationAndTrainData()
    }
    
    func didSelectTrainLine(_ line: TrainLine) {
        let sfc = SFSafariViewController(url: line.statusUrl)
        present(sfc, animated: true)
    }
    
    func didSelectArrivals(_ arrivals: StationArrivals) {
        print("Arrivals was selected for: \(arrivals.stop.name)")
    }
}

private extension RootViewController {
    
    func setupWillEnterForegroundNotificationSubscription() {
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveAppWillEnterForegroundNotification), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func didReceiveAppWillEnterForegroundNotification() {
        refreshLocationAndTrainData()
    }
    
    func refreshLocationAndTrainData() {
        if locationHandler.permissionStatus == .granted {
            makeRequestsWithLocationPermission()
        }
        else {
            makeRequestsWithoutLocationPermission()
        }
    }
    
    func getCurrentLocation(completion: @escaping () -> Void) {
        locationHandler.fetchCurrentLocation() { coordinate in
            self.currentDeviceCoordinate = coordinate
            completion()
        }
    }
    
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
