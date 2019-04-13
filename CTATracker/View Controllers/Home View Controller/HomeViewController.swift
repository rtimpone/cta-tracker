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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        super.prepare(for: segue, sender: self)
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
        let svc = StationViewController.instance(withArrivals: arrivals)
        navigationController?.pushViewController(svc, animated: true)
    }
    
    func didSelectEditRoutes() {
        let srvc = SelectRoutesViewController.instance(withDelegate: self)
        navigationController?.pushViewController(srvc, animated: true)
    }
    
    func didSelectEditStops() {
        let ssvc = SelectStopsViewController.instance(withDelegate: self)
        navigationController?.pushViewController(ssvc, animated: true)
    }
}

extension HomeViewController: SelectRoutesViewControllerDelegate {
    
    func didUpdateFavoriteRoutes() {
//        tableViewController.refreshRoutes()
    }
}

extension HomeViewController: SelectStopsViewControllerDelegate {
    
    func didAddStopToFavorites(_ stop: Stop) {
        tableViewController.addPlaceholderArrivals(for: stop)
    }
    
    func didRemoveStopsFromFavorites(_ stop: Stop) {
        tableViewController.removeArrivals(for: stop)
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
        refreshRoutesDataFromApi()
        refreshArrivalsDataFromApi()
    }
    
    func refreshRoutesDataFromApi() {
        statusRequestHandler.requestTrainStatus() { result in
            switch result {
            case .success(let routes):
                self.tableViewController.displayRouteStatuses(routes)
            case .error:
                self.tableViewController.displayRoutesStatusError()
            }
        }
    }
    
    func refreshArrivalsDataFromApi() {
        arrivalsRequestHandler.requestTrainStopArrivalTimes(currentLocation: currentDeviceCoordinate) { result in
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
