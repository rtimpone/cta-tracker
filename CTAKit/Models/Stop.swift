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
    public let routes: [Route]
    
    init(from data: PlatformData) {
        
        id = data.id
        name = "\(data.stationName) (\(data.platformDescription))"
        latitude = data.latitude
        longitude = data.longitude
        
        let allRoutes = RouteDataFetcher.fetchAllRoutes()
        
        var routes: [Route] = []
        
        if data.hasRed {
            let redLine = allRoutes.first(where: { $0.title == "Red Line" })!
            routes.append(redLine)
        }
        
        if data.hasBlue {
            let blueLine = allRoutes.first(where: { $0.title == "Blue Line" })!
            routes.append(blueLine)
        }
        
        if data.hasGreen {
            let greenLine = allRoutes.first(where: { $0.title == "Green Line" })!
            routes.append(greenLine)
        }
        
        if data.hasBrown {
            let brownLine = allRoutes.first(where: { $0.title == "Brown Line" })!
            routes.append(brownLine)
        }
        
        if data.hasPurple {
            let purpleLine = allRoutes.first(where: { $0.title == "Purple Line" })!
            routes.append(purpleLine)
        }
        
        if data.hasPurpleExpress {
            let purpleLineExpress = allRoutes.first(where: { $0.title == "Purple Line Express" })!
            routes.append(purpleLineExpress)
        }
        
        if data.hasYellow {
            let yellowLine = allRoutes.first(where: { $0.title == "Yellow Line" })!
            routes.append(yellowLine)
        }
        
        if data.hasPink {
            let pinkLine = allRoutes.first(where: { $0.title == "Pink Line" })!
            routes.append(pinkLine)
        }
        
        if data.hasOrange {
            let orangeLine = allRoutes.first(where: { $0.title == "Orange Line" })!
            routes.append(orangeLine)
        }
        
        self.routes = routes
    }
}
