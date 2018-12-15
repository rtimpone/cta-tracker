//
//  TrainArrival.swift
//  CTAKit
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import Foundation

public enum Route: String {
    case brown = "Brn"
    case unknown
}

public struct Station {
    public let name: String
    public let route: Route
}

public struct StationArrivals {
    
    public let station: Station
    public let etas: [ETA]
    
    init?(from responses: [ArrivalETAResponse]) {
        
        guard let anyArrival = responses.first else {
            return nil
        }
            
        let route = Route(rawValue: anyArrival.routeCode) ?? .unknown
        station = Station(name: anyArrival.stationName, route: route)
        
        let unsortedArrivals = responses.compactMap { ETA(from: $0) }
        etas = unsortedArrivals.sorted { $0.arrivalTime < $1.arrivalTime }
    }
}

public struct ETA {
    
    public let destination: String
    public let arrivalTime: Date
    public let isApproaching: Bool
    public let isScheduled: Bool
    public let isDelayed: Bool
    public let isFault: Bool
    
    static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss ZZZZ"
        return df
    }()
    
    init?(from response: ArrivalETAResponse) {
        
        let arrivalTimeWithOffset = response.arrivalTimeString + " " + UTCOffsets.chicago
        guard let arrivalTime = ETA.dateFormatter.date(from: arrivalTimeWithOffset) else {
            return nil
        }
        
        self.destination = response.destination
        self.arrivalTime = arrivalTime
        self.isApproaching = Bool(response.isApproachingString) ?? false
        self.isScheduled = Bool(response.isScheduledString) ?? false
        self.isDelayed = Bool(response.isDelayedString) ?? false
        self.isFault = Bool(response.isScheduleFaultString) ?? false
    }
}
