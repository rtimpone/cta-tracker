//
//  TrainArrival.swift
//  CTAKit
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import Foundation

public struct StationArrivals {
    
    public let stop: TrainStop
    public let etas: [ETA]
    
    init?(from responses: [ArrivalETAResponse], for stop: TrainStop) {
        self.stop = stop
        let unsortedArrivals = responses.compactMap { ETA(from: $0) }
        etas = unsortedArrivals.sorted { $0.arrivalTime < $1.arrivalTime }
    }
}

public struct ETA {

    public let route: Route
    public let status: ArrivalStatus
    public let destination: String
    public let arrivalTime: Date
    
    private static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss ZZZZ"
        return df
    }()
    
    init?(from response: ArrivalETAResponse) {
        
        self.route = Route.allRoutes().first { $0.id == response.routeCode }!
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
            status = ArrivalStatus.approaching
        }
        else if isDelayed {
            status = ArrivalStatus.delayed
        }
        else if isFault {
            status = ArrivalStatus.unavailable
        }
        else {
            
            let now = Date()
            let exactSecondsUntilArrival = arrivalTime.timeIntervalSince(now)
            let intSecondsUntilArrival = Int(exactSecondsUntilArrival)
            
            if isScheduled {
                status = ArrivalStatus.scheduled(seconds: intSecondsUntilArrival)
            }
            else {
                status = ArrivalStatus.enRoute(seconds: intSecondsUntilArrival)
            }
        }
    }
}

public enum ArrivalStatus {

    /// The train is on its way as normal
    case enRoute(seconds: Int)
    
    /// A train is scheduled to arrive but has not yet left
    case scheduled(seconds: Int)
    
    /// The train is approaching the station and will arrive soon
    case approaching
    
    /// The train is delayed and no estiamte is available
    case delayed
    
    /// The train's arrival time estimate is unreliable or unavailable
    case unavailable
}
