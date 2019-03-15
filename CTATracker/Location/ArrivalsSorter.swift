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
        return arrivals.sorted(by: {
            return DistanceCalculator.distance(from: $0.stop, to: coordinate) < DistanceCalculator.distance(from: $1.stop, to: coordinate)
        })
    }
}
