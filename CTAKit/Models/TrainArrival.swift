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

public struct Arrival {
    
    let stationId: Int
    let stationName: String
    let route: Route
    let destination: String
    let arrivalTime: Date
    let isApproaching: Bool
    let isScheduled: Bool
    let isDelayed: Bool
    let isFault: Bool
    
    init?(from response: ArrivalETAResponse) {
        
        guard let id = Int(response.stationId) else {
            return nil
        }
        
        let df = DateFormatter()
        df.dateFormat = ""
        
        
        //need to implement date format here !
        //"arrT": "2018-12-14T15:39:18",
        
        guard let arrivalTime = df.date(from: response.arrivalTimeString) else {
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
