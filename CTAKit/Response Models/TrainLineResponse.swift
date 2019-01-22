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
    
    let serviceId: String
    let title: String
    let routeColorCode: String?
    let textColorCode: String?
    let status: String
    let statusUrl: NestedRouteURL
    
    struct NestedRouteURL: Decodable {
        let url: URL
        enum CodingKeys: String, CodingKey {
            case url = "#cdata-section"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case serviceId = "ServiceId"
        case title = "Route"
        case routeColorCode = "RouteColorCode"
        case textColorCode = "RouteTextColor"
        case status = "RouteStatus"
        case statusUrl = "RouteURL"
    }
}
