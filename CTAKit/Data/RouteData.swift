//
//  RouteData.swift
//  CTAKit
//
//  Created by Rob Timpone on 1/20/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import Foundation

struct RouteDataContainer: Decodable {
    
    let routes: [RouteData]
    
    enum CodingKeys: String, CodingKey {
        case routes = "routes"
    }
}

struct RouteData: Decodable {
    
    let id: String
    let title: String
    let colorHexValue: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case colorHexValue = "color"
    }
}
