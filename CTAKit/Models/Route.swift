//
//  Route.swift
//  CTAKit
//
//  Created by Rob Timpone on 1/20/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import Foundation

public struct Route: Hashable {
    
    public let id: String
    public let title: String
    public let color: UIColor
    public let url: URL
    
    init(from data: RouteData) {
        id = data.id
        title = data.title
        color = UIColor(hex: data.colorHexValue)
        url = data.url
    }
}
