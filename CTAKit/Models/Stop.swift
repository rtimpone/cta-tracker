//
//  Stop.swift
//  CTAKit
//
//  Created by Rob Timpone on 12/24/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import Foundation

public enum StopType {
    case station
    case platform
}

public protocol Stop {
    
    var id: Int { get }
    var name: String { get }
    var latitude: Double { get }
    var longitude: Double { get }
    var type: StopType { get }
}

public struct Station: Stop {
    
    public let id: Int
    public let name: String
    public let latitude: Double
    public let longitude: Double
    public let platforms: [Platform]
    public let type: StopType = .station
    
    init(id: Int, name: String, latitude: Double, longitude: Double, platforms: [Platform]) {
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.platforms = platforms
    }
}

public struct Platform: Stop {
    
    public let id: Int
    public let name: String
    public let latitude: Double
    public let longitude: Double
    public let type: StopType = .platform
    
    init(from data: PlatformData) {
        id = data.id
        name = "\(data.stationName) (\(data.platformDescription))"
        latitude = data.latitude
        longitude = data.longitude
    }
}
