//
//  TrainLine.swift
//  CTAKit
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import Foundation
import UIKit

public struct TrainLine {
    
    public let id: String
    public let title: String
    public let displayColor: UIColor
    public let statusUrl: URL
    
    public private(set) var alerts: [Alert] = []
    
    init(fromResponse response: RouteStatusResponse) {
        id = response.serviceId
        title = response.title
        
        if let routeColor = response.routeColorCode {
            displayColor = UIColor(hex: routeColor)
        }
        else {
            displayColor = .white
        }
        
        statusUrl = response.statusUrl.url
    }
    
    public mutating func addAlerts(_ alerts: [Alert]) {
        self.alerts.append(contentsOf: alerts)
    }
}
