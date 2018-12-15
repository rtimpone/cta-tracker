//
//  TrainLineResponse.swift
//  CTAKit
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import Foundation

struct RouteInfoContainer: Decodable {
    
    let info: RouteInfo
    
    enum CodingKeys: String, CodingKey {
        case info = "CTARoutes"
    }
}

struct RouteInfo: Decodable {
    
    let routeStatusResponses: [RouteStatusResponse]
    
    enum CodingKeys: String, CodingKey {
        case routeStatusResponses = "RouteInfo"
    }
}

struct RouteStatusResponse: Decodable {
    
    let id: String
    let title: String
    let routeColorCode: String?
    let textColorCode: String?
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case id = "ServiceId"
        case title = "Route"
        case routeColorCode = "RouteColorCode"
        case textColorCode = "RouteTextColor"
        case status = "RouteStatus"
    }
}
