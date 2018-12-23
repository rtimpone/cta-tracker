//
//  TrainArrival.swift
//  CTAKit
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import Foundation

public enum Route: String {
    
    case red = "Red"
    case blue = "Blue"
    case brown = "Brn"
    case green = "G"
    case orange = "Org"
    case purple = "P"
    case pink = "Pink"
    case yellow = "Y"
    case unknown
    
    public var color: UIColor {
        switch self {
        case .red:
            return UIColor(hex: "c60c30")
        case .blue:
            return UIColor(hex: "00a1de")
        case .brown:
            return UIColor(hex: "62361b")
        case .green:
            return UIColor(hex: "009b3a")
        case .orange:
            return UIColor(hex: "f9461c")
        case .purple:
            return UIColor(hex: "522398")
        case .pink:
            return UIColor(hex: "e27ea6")
        case .yellow:
            return UIColor(hex: "f9e300")
        case .unknown:
            return .lightGray
        }
    }
}

public struct Station {
    public let name: String
}

public struct StationArrivals {
    
    public let station: Station
    public let etas: [ETA]
    
    init?(from responses: [ArrivalETAResponse]) {
        
        guard let anyArrival = responses.first else {
            return nil
        }
        station = Station(name: anyArrival.stationName)
        
        let unsortedArrivals = responses.compactMap { ETA(from: $0) }
        etas = unsortedArrivals.sorted { $0.arrivalTime < $1.arrivalTime }
    }
}

public struct ETA {

    public let route: Route
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
        
        self.route = Route(rawValue: response.routeCode) ?? .unknown
        self.destination = response.destination
        self.arrivalTime = arrivalTime
        self.isApproaching = Bool(response.isApproachingString) ?? false
        self.isScheduled = Bool(response.isScheduledString) ?? false
        self.isDelayed = Bool(response.isDelayedString) ?? false
        self.isFault = Bool(response.isScheduleFaultString) ?? false
    }
}
