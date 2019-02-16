//
//  ArrivalsSorter.swift
//  CTATracker
//
//  Created by Rob Timpone on 1/5/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CoreLocation
import CTAKit

class ArrivalsSorter {
    
    static func sortArrivals(_ arrivals: [StopArrivals], byDistanceTo coordinate: Coordinate) -> [StopArrivals] {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        return arrivals.sorted(by: {
            return distance(from: $0.stop, to: location) < distance(from: $1.stop, to: location)
        })
    }
}

private extension ArrivalsSorter {
    
    static func distance(from stop: Stop, to location: CLLocation) -> Double {
        let stopLocation = CLLocation(latitude: stop.latitude, longitude: stop.longitude)
        return stopLocation.distance(from: location)
    }
}
