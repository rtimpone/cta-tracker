//
//  TrainArrivalResponse.swift
//  CTAKit
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import Foundation

struct ArrivalsContainerResponse: Decodable {
    
    let root: ArrivalsETAsContainerResponse
    
    enum CodingKeys: String, CodingKey {
        case root = "ctatt"
    }
}

struct ArrivalsETAsContainerResponse: Decodable {
    
    let etas: [ArrivalETAResponse]
    
    enum CodingKeys: String, CodingKey {
        case etas = "eta"
    }
}

struct ArrivalETAResponse: Decodable {
    
    let stationId: String
    let stationName: String
    let routeCode: String
    let destination: String
    let arrivalTimeString: String
    let isApproachingString: String
    let isScheduledString: String
    let isDelayedString: String
    let isScheduleFaultString: String
    
    enum CodingKeys: String, CodingKey {
        case stationId = "staId"
        case stationName = "staNm"
        case routeCode = "rt"
        case destination = "destNm"
        case arrivalTimeString = "arrT"
        case isApproachingString = "isApp"
        case isScheduledString = "isSch"
        case isDelayedString = "isDly"
        case isScheduleFaultString = "isFlt"
    }
}
