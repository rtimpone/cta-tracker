//
//  StationDataFetcher.swift
//  CTAKit
//
//  Created by Rob Timpone on 1/30/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import Foundation

struct StationData: Decodable {
    
    let id: Int
    let name: String
    let latitude: Double
    let longitude: Double
    let platforms: [PlatformData]
}

struct PlatformData: Decodable {
    
    let id: Int
    let name: String
}

public class StationDataFetcher: DataFetcher {
    
    public static func fetchAllStations() -> [Station] {
        let stationDataObjects = decodeObject(ofType: [StationData].self, fromFileNamed: "stations", ofType: "json")
        return stationDataObjects.compactMap { Station(from: $0) }
    }
}
