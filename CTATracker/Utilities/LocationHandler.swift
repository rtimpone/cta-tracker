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

class LocationHandler: NSObject {
    
    typealias PermissionRequestCompletion = (_ permissionWasGranted: Bool) -> Void
    
    let manager: CLLocationManager
    var permissionRequestCompletion: PermissionRequestCompletion?
    
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
    
    func requestLocationPermission(completion: @escaping PermissionRequestCompletion) {
        
        let currentStatus = fetchCurrentPermissionStatus()
        guard currentStatus == .notYetRequested else {
            return
        }
        
        permissionRequestCompletion = completion
        manager.requestWhenInUseAuthorization()
    }
}

extension LocationHandler: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            permissionRequestCompletion?(true)
            permissionRequestCompletion = nil
        case .denied, .restricted:
            permissionRequestCompletion?(false)
            permissionRequestCompletion = nil
        case .notDetermined:
            break
        }
    }
}
