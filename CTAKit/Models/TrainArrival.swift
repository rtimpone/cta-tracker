//
//  TrainArrival.swift
//  CTAKit
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import Foundation

public struct StopArrivals {
    
    public let stop: Stop
    public let etas: [ETA]
    
    init(from responses: [ArrivalETAResponse], for stop: Stop) {
        self.stop = stop
        let unsortedArrivals = responses.compactMap { ETA(from: $0) }
        etas = unsortedArrivals.sorted { $0.secondsUntilArrival < $1.secondsUntilArrival }
    }
    
    public static func emptyArrivals(for stop: Stop) -> StopArrivals {
        return StopArrivals(from: [], for: stop)
    }
}

public struct ETA {

    public let route: Route
    public let status: ArrivalStatus
    public let destination: String
    public let arrivalTime: Date
    
    public var secondsUntilArrival: Int {
        let now = Date()
        let exactSecondsUntilArrival = arrivalTime.timeIntervalSince(now)
        return Int(exactSecondsUntilArrival)
    }
    
    private static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss ZZZZ"
        return df
    }()
    
    init?(from response: ArrivalETAResponse) {
        
        // TODO: this is temporary until data modeling is cleaned up
        self.route = RouteDataFetcher.fetchAllRoutes().first { $0.id == response.routeCode }!
        self.destination = response.destination
        
        let arrivalTimeWithOffset = response.arrivalTimeString + " " + UTCOffsets.chicago
        guard let arrivalTime = ETA.dateFormatter.date(from: arrivalTimeWithOffset) else {
            return nil
        }
        self.arrivalTime = arrivalTime
        
        let isApproaching = Bool(response.isApproachingString) ?? false
        let isScheduled = Bool(response.isScheduledString) ?? false
        let isDelayed = Bool(response.isDelayedString) ?? false
        let isFault = Bool(response.isScheduleFaultString) ?? false
        
        if isApproaching {
            status = .approaching
        }
        else if isDelayed {
            status = .delayed
        }
        else if isFault {
            status = .unavailable
        }
        else {
            if isScheduled {
                status = .scheduled
            }
            else {
                status = .enRoute
            }
        }
    }
}

public enum ArrivalStatus {

    /// The train is on its way as normal
    case enRoute
    
    /// A train is scheduled to arrive but has not yet left
    case scheduled
    
    /// The train is approaching the station and will arrive soon
    case approaching
    
    /// The train is delayed and no estiamte is available
    case delayed
    
    /// The train's arrival time estimate is unreliable or unavailable
    case unavailable
}
