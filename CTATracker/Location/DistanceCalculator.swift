//
//  DistanceCalculator.swift
//  CTATracker
//
//  Created by Rob Timpone on 3/2/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CoreLocation
import CTAKit

struct DistanceCalculator {
    
    static func distance(from stop: Stop, to location: Coordinate) -> Double {
        let location = CLLocation(latitude: location.latitude, longitude: location.longitude)
        let stopLocation = CLLocation(latitude: stop.latitude, longitude: stop.longitude)
        return stopLocation.distance(from: location)
    }
}
