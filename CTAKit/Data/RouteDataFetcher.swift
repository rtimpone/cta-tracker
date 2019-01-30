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

public class RouteDataFetcher {
    
    public static func fetchAllRoutes() -> [Route] {
        let data = fetchRoutesFileData()
        let decoder = JSONDecoder()
        let routeDataObjects = try! decoder.decode([RouteData].self, from: data)
        return routeDataObjects.compactMap { Route(from: $0) }
    }
}

private extension RouteDataFetcher {
    
    static func fetchRoutesFileData() -> Data {
        let bundle = Bundle(for: RouteDataFetcher.self)
        let path = bundle.path(forResource: "routes", ofType: "json")!
        return FileManager.default.contents(atPath: path)!
    }
}
