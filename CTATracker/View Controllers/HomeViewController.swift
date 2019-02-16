//
//  HomeViewController.swift
//  CTATracker
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import CTAKit
import SafariServices
import UIKit

class HomeViewController: UIViewController {
    
    let locationHandler = LocationHandler()
    let arrivalsRequestHandler = ArrivalsRequestHandler()
    let statusRequestHandler = StatusRequestHandler()
    
    weak var tableViewController: HomeTableViewController!
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
        if let vc = segue.destination as? HomeTableViewController {
            vc.delegate = self
            tableViewController = vc
        }
    }
}

extension HomeViewController: HomeTableViewControllerDelegate {
    
    func refreshControlWasActivated() {
        refreshLocationAndTrainData()
    }
    
    func didSelectStatus(_ status: RouteStatus) {
        let sfc = SFSafariViewController(url: status.route.url)
        present(sfc, animated: true)
    }
    
    func didSelectArrivals(_ arrivals: StopArrivals) {
        print("Arrivals was selected for: \(arrivals.stop.name)")
        let svc = StationViewController.instance()
        navigationController?.pushViewController(svc, animated: true)
    }
}

private extension HomeViewController {
    
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
            case .success(let routes):
                self.tableViewController.displayRouteStatuses(routes)
            case .error:
                self.tableViewController.displayRoutesStatusError()
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
