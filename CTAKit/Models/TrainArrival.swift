//
//  TrainArrival.swift
//  CTAKit
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import Foundation

enum Route: String {
    case brown = "Brn"
    case unknown
}

public struct TrainArrival {
    
    let stationId: Int
    public let stationName: String
    let route: Route
    public let destination: String
    public let arrivalTime: Date
    let isApproaching: Bool
    let isScheduled: Bool
    let isDelayed: Bool
    let isFault: Bool
    
    static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss ZZZZ"
        return df
    }()
    
    init?(from response: ArrivalETAResponse) {
        
        guard let id = Int(response.stationId) else {
            return nil
        }
        
        let arrivalTimeWithOffset = response.arrivalTimeString + " " + UTCOffsets.chicago
        guard let arrivalTime = TrainArrival.dateFormatter.date(from: arrivalTimeWithOffset) else {
            return nil
        }
        
        self.stationId = id
        self.stationName = response.stationName
        self.route = Route(rawValue: response.routeCode) ?? .unknown
        self.destination = response.destination
        self.arrivalTime = arrivalTime
        self.isApproaching = Bool(response.isApproachingString) ?? false
        self.isScheduled = Bool(response.isScheduledString) ?? false
        self.isDelayed = Bool(response.isDelayedString) ?? false
        self.isFault = Bool(response.isScheduleFaultString) ?? false
    }
}
