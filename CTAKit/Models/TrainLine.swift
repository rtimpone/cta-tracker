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
    public let status: Status
    
    public enum Status: String {
        case normal = "Normal Service"
        case minorDelays = "Minor Delays"
        case majorDelays = "Major Delays"
        case significantDelays = "Significant Delays"
        case unknown = "Unknown"
    }
    
    init(fromResponse response: RouteStatusResponse) {
        id = response.id
        title = response.title
        
        if let routeColor = response.routeColorCode {
            displayColor = UIColor(hex: routeColor)
        }
        else {
            displayColor = .white
        }
        
        status = Status(rawValue: response.status) ?? .unknown
    }
}
