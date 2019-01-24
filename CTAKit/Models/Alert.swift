//
//  Alert.swift
//  CTAKit
//
//  Created by Rob Timpone on 1/19/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import Foundation

public struct Alert {
    
    public let headline: String
    public let message: String
    public let severity: Int
    public let impact: String
    public let routesImpacted: [Route]
    
    init(from response: AlertResponse) {
        headline = response.headline
        message = response.shortDescription
        severity = Int(response.severityScore) ?? 0
        impact = response.impact
        
        let impactedServices = response.impactedServicesContainer.services
        let idsOfRoutesImpacted = impactedServices.map { $0.serviceId }
        routesImpacted = Route.allRoutes().filter { idsOfRoutesImpacted.contains($0.id) }
    }
}
