//
//  PermissionHandler.swift
//  CTATracker
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import CoreLocation

enum PermissionStatus {
    case granted
    case denied
    case notYetRequested
}

struct Coordinate {
    var latitude: Double
    var longitude: Double
}

class LocationHandler: NSObject {
    
    typealias RequestPermissionCompletion = (_ permissionWasGranted: Bool) -> Void
    typealias FetchLocationCompletion = (Coordinate) -> Void
    
    let manager: CLLocationManager
    var requestPermissionCompletion: RequestPermissionCompletion?
    var fetchLocationCompletion: FetchLocationCompletion?
    
    override init() {
        manager = CLLocationManager()
        super.init()
        manager.delegate = self
    }
    
    func fetchCurrentPermissionStatus() -> PermissionStatus {
        
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            return .granted
        case .denied, .restricted:
            return .denied
        case .notDetermined:
            return .notYetRequested
        }
    }
    
    func fetchCurrentLocation(completion: @escaping FetchLocationCompletion) {
        fetchLocationCompletion = completion
        manager.startUpdatingLocation()
    }
    
    func requestLocationPermission(completion: @escaping RequestPermissionCompletion) {
        
        let currentStatus = fetchCurrentPermissionStatus()
        guard currentStatus == .notYetRequested else {
            return
        }
        
        requestPermissionCompletion = completion
        manager.requestWhenInUseAuthorization()
    }
}

extension LocationHandler: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            requestPermissionCompletion?(true)
        case .denied, .restricted:
            requestPermissionCompletion?(false)
        case .notDetermined:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        if let mostRecentLocation = locations.last {
            let coordinate = Coordinate(latitude: mostRecentLocation.coordinate.latitude, longitude: mostRecentLocation.coordinate.longitude)
            fetchLocationCompletion?(coordinate)
            fetchLocationCompletion = nil
        }
    }
}
