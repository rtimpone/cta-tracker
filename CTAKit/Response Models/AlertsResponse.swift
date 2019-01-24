//
//  AlertsResponse.swift
//  CTAKit
//
//  Created by Rob Timpone on 1/19/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import Foundation

struct AlertsContainerResponse: Decodable {
    
    let root: AlertsListResponse
    
    enum CodingKeys: String, CodingKey {
        case root = "CTAAlerts"
    }
}

struct AlertsListResponse: Decodable {
    
    let alerts: [AlertResponse]
    
    enum CodingKeys: String, CodingKey {
        case alerts = "Alert"
    }
}

struct AlertResponse: Decodable {
    
    let headline: String
    let shortDescription: String
    let severityScore: String
    let impactedServicesContainer: ImpactedServicesContainerResponse
    
    enum CodingKeys: String, CodingKey {
        case headline = "Headline"
        case shortDescription = "ShortDescription"
        case severityScore = "SeverityScore"
        case impactedServicesContainer = "ImpactedService"
    }
}

struct ImpactedServicesContainerResponse: Decodable {
    
    let services: [ServiceResponse]
    
    enum CodingKeys: String, CodingKey {
        case services = "Service"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // services can be a dictionary for a single service, or an array for multiple services
        // attempt to decode it as a dictionary first, then fall back to decoding it as an array
        
        if let service = try? container.decode(ServiceResponse.self, forKey: .services) {
            services = [service]
        }
        else {
            services = try container.decode([ServiceResponse].self, forKey: .services)
        }
    }
}

struct ServiceResponse: Decodable {
    
    let serviceId: String
    
    enum CodingKeys: String, CodingKey {
        case serviceId = "ServiceId"
    }
}
