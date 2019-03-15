//
//  StationDataFetcher.swift
//  CTAKit
//
//  Created by Rob Timpone on 1/30/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import Foundation

struct PlatformData: Decodable {
    
    let id: Int
    let stationId: Int
    let direction: String
    let stationName: String
    let platformDescription: String
    let hasRed: Bool
    let hasBlue: Bool
    let hasGreen: Bool
    let hasBrown: Bool
    let hasPurple: Bool
    let hasPurpleExpress: Bool
    let hasYellow: Bool
    let hasPink: Bool
    let hasOrange: Bool
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case id = "platform_id"
        case stationId = "station_id"
        case direction = "direction"
        case stationName = "station_name"
        case platformDescription = "platform_description"
        case hasRed = "has_red"
        case hasBlue = "has_blue"
        case hasGreen = "has_green"
        case hasBrown = "has_brown"
        case hasPurple = "has_purple"
        case hasPurpleExpress = "has_purple_express"
        case hasYellow = "has_yellow"
        case hasPink = "has_pink"
        case hasOrange = "has_orange"
        case latitude = "latitude"
        case longitude = "longitude"
    }
}

public class StationDataFetcher: DataFetcher {
    
    public static func fetchAllStations() -> [Station] {
        
        let platformDataObjects = decodeObject(ofType: [PlatformData].self, fromFileNamed: "platforms", ofType: "json")
        var platformDataObjectsForStation: [Int: [PlatformData]] = [:]
        
        for platformData in platformDataObjects {
            var platforms = platformDataObjectsForStation[platformData.stationId] ?? []
            platforms.append(platformData)
            platformDataObjectsForStation[platformData.stationId] = platforms
        }
        
        var stations: [Station] = []
        for (stationId, platformDataObjects) in platformDataObjectsForStation {
            guard let firstPlatform = platformDataObjects.first else {
                continue
            }
            let platforms = platformDataObjects.compactMap{ Platform(from: $0) }
            let station = Station(id: stationId,
                                  name: firstPlatform.stationName,
                                  latitude: firstPlatform.latitude,
                                  longitude: firstPlatform.longitude,
                                  platforms: platforms)
            stations.append(station)
        }
        
        return stations
    }
}
