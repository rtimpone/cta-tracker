//
//  Alert.swift
//  CTAKit
//
//  Created by Rob Timpone on 1/19/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import Foundation

public struct Alert {
    
    /// A title describing the type of alert (example: "Trains bypassing 69th Station")
    public let headline: String
    
    /// A short description of what the issue is (example: "Red Line trains are not stopping at 69th due to police activity")
    public let message: String
    
    /// A number from 1-99 that indicates how severe the issue is, 99 is most sever, 1 is least severe. Anything 40 or higher is a delay.
    public let severity: Int
    
    /// A category describing the impact of the issue (examples: Minor Delays, Major Delays, Service Disruption)
    public let impact: String
    
    /// The routes that will be impacted by the issue related to this alert 
    public let routesImpacted: [Route]
    
    /// Whether this alert indicates an unanticipated delay. A severity score above 40 is considered severe since it indicates some kind of delay.
    public var isSevere: Bool {
        return severity >= 40
    }
    
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
