//
//  TrainStop.swift
//  CTAKit
//
//  Created by Rob Timpone on 12/24/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import Foundation

public enum StopType {
    case platform
    case station
}

public struct TrainStop: Hashable {
    
    public let id: Int
    public let name: String
    public let type: StopType
    public let latitude: Double
    public let longitude: Double
    
    public init(id: Int, name: String, type: StopType, latitude: Double, longitude: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.latitude = latitude
        self.longitude = longitude
    }
    
    public static let allStops = [
        TrainStop(id: 30131, name: "Adams/Wabash (Northbound)", type: .platform, latitude: 41.879507, longitude: -87.626037),
        TrainStop(id: 30019, name: "Damen (Loop-bound)", type: .platform, latitude: 41.966286, longitude: -87.678639),
        TrainStop(id: 41320, name: "Belmont", type: .station, latitude: 41.939751, longitude: -87.65338),
        TrainStop(id: 30021, name: "Morse (Howard-bound)", type: .platform, latitude: 42.008362, longitude: -87.665909),
        TrainStop(id: 30211, name: "Monroe (95th-bound)", type: .platform, latitude: 41.880745, longitude: -87.627696)
    ]
}
