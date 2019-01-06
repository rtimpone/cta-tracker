//
//  TrainStop.swift
//  CTAKit
//
//  Created by Rob Timpone on 12/24/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import Foundation

public struct TrainStop {
    
    enum StopType {
        case platform
        case station
    }
    
    let id: Int
    let name: String
    let type: StopType
    let latitude: Double
    let longitude: Double
    
    public static let allStops = [
        TrainStop(id: 30131, name: "Adams/Wabash (Northbound)", type: .platform, latitude: 41.879507, longitude: -87.626037),
        TrainStop(id: 30019, name: "Damen (Loop-bound)", type: .platform, latitude: 41.966286, longitude: -87.678639),
        TrainStop(id: 41320, name: "Belmont", type: .station, latitude: 41.939751, longitude: -87.65338),
        TrainStop(id: 30258, name: "Belmont (Loop-bound)", type: .platform, latitude: 41.939751, longitude: -87.65338),
        TrainStop(id: 30256, name: "Belmont (95th-bound)", type: .platform, latitude: 41.939751, longitude: -87.65338),
        TrainStop(id: 30255, name: "Belmont (Howard-bound)", type: .platform, latitude: 41.939751, longitude: -87.65338),
        TrainStop(id: 30257, name: "Belmont (Kimball-Linden-bound)", type: .platform, latitude: 41.939751, longitude: -87.65338),
        TrainStop(id: 30021, name: "Morse (95th-bound)", type: .platform, latitude: 42.008362, longitude: -87.665909),
        TrainStop(id: 30211, name: "Monroe (95th-bound)", type: .platform, latitude: 41.880745, longitude: -87.627696)
    ]
}
