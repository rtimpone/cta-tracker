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
    
    typealias RequestPermissionCompletion = () -> Void
    typealias FetchLocationCompletion = (Coordinate) -> Void
    
    let manager: CLLocationManager
    var requestPermissionCompletion: RequestPermissionCompletion?
    var fetchLocationCompletion: FetchLocationCompletion?
    
    var permissionStatus: PermissionStatus {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            return .granted
        case .denied, .restricted:
            return .denied
        case .notDetermined:
            return .notYetRequested
        @unknown default:
            fatalError("Unsupported authorization status")
        }
    }
    
    override init() {
        manager = CLLocationManager()
        super.init()
        manager.delegate = self
    }
    
    func fetchCurrentLocation(completion: @escaping FetchLocationCompletion) {
        fetchLocationCompletion = completion
        manager.startUpdatingLocation()
    }
    
    func requestLocationPermission(completion: @escaping RequestPermissionCompletion) {
        
        guard permissionStatus == .notYetRequested else {
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
            requestPermissionCompletion?()
        case .denied, .restricted:
            requestPermissionCompletion?()
        case .notDetermined:
            break
        @unknown default:
            fatalError("Unsupported authorization status")
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
