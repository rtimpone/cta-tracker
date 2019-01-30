//
//  Route.swift
//  CTAKit
//
//  Created by Rob Timpone on 1/20/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import Foundation

public struct Route {
    
    public let id: String
    public let title: String
    public let color: UIColor
    
    init(from data: RouteData) {
        id = data.id
        title = data.title
        color = UIColor(hex: data.colorHexValue)
    }
    
    static func allRoutes() -> [Route] {
        return RoutesFetcher.fetchAllRoutes()
    }
}

class RoutesFetcher {
    
    static func fetchAllRoutes() -> [Route] {
        let bundle = Bundle(for: RoutesFetcher.self)
        let path = bundle.path(forResource: "routes", ofType: "json")!
        let data = FileManager.default.contents(atPath: path)!
        let decoder = JSONDecoder()
        let container = try! decoder.decode(RouteDataContainer.self, from: data)
        return container.routes.compactMap { Route(from: $0) }
    }
}
