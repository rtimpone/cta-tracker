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
        applyCurrentTheme()
    }
    
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
    
    @IBAction func searchAction(_ sender: UIBarButtonItem) {
        let vc = SelectSingleStopViewController.instantiateFromStoryboard()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func settingsAction(_ sender: UIBarButtonItem) {
        let nvc = SettingsViewController.instantiateNavigationControllerWithSettingsViewController(delegate: self)
        present(nvc, animated: true)
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
        let svc = StationViewController.instance(for: arrivals.stop, withArrivals: arrivals)
        navigationController?.pushViewController(svc, animated: true)
    }
    
    func didSelectEditRoutes() {
        let srvc = SelectRoutesViewController.instance(withDelegate: self)
        navigationController?.pushViewController(srvc, animated: true)
    }
    
    func didSelectEditStops() {
        let sfsvc = SelectFavoriteStopsViewController.instance(withDelegate: self)
        navigationController?.pushViewController(sfsvc, animated: true)
    }
}

extension HomeViewController: SelectRoutesViewControllerDelegate {
    
    func didAddRouteToFavorites(_ route: Route) {
        tableViewController.addPlaceholderRouteStatus(for: route)
    }
    
    func didRemoveRouteFromFavorites(_ route: Route) {
        tableViewController.removeRouteStatus(for: route)
    }
}

extension HomeViewController: SelectFavoriteStopsViewControllerDelegate {
    
    func didAddStopToFavorites(_ stop: Stop) {
        tableViewController.addPlaceholderArrivals(for: stop)
    }
    
    func didRemoveStopsFromFavorites(_ stop: Stop) {
        tableViewController.removeArrivals(for: stop)
    }
}

extension HomeViewController: SettingsViewControllerDelegate {
    
    func themeDidChange(to theme: Theme) {
        applyTheme(theme)
    }
}

extension HomeViewController: Themeable {
    
    func applyTheme(_ theme: Theme) {
        
        guard let navBar = navigationController?.navigationBar else {
            return
        }
        
        view.backgroundColor = theme.backgroundTheme.backgroundColor
        
        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: theme.navBarTheme.titleColor]
        navBar.tintColor = theme.navBarTheme.buttonColor
        navBar.barTintColor = theme.navBarTheme.backgroundColor
        
        tableViewController?.applyTheme(theme)
        
        if let nvc = navigationController as? StatusBarCustomizableNavigationViewController {
            nvc.setStatusBarStyle(theme.statusBarTheme.style)
        }
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

