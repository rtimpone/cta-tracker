//
//  RouteStatus.swift
//  CTAKit
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import Foundation
import UIKit

public class RouteStatus {
    
    public let route: Route
    public let alerts: [Alert]
    
    public init(route: Route, alerts: [Alert]) {
        self.route = route
        self.alerts = alerts
    }
}
