//
//  RouteDataFetcher.swift
//  CTAKit
//
//  Created by Rob Timpone on 1/30/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import Foundation

struct RouteData: Decodable {
    
    let id: String
    let title: String
    let colorHexValue: String
    let url: URL
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case colorHexValue = "color"
        case url = "url"
    }
}

public class RouteDataFetcher: DataFetcher {
    
    public static func fetchAllRoutes() -> [Route] {
        let routeDataObjects = decodeObject(ofType: [RouteData].self, fromFileNamed: "routes", ofType: "json")
        return routeDataObjects.compactMap { Route(from: $0) }
    }
}
