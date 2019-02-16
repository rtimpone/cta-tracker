//
//  MockJson.swift
//  CTAKitTests
//
//  Created by Rob Timpone on 1/21/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import Foundation

struct MockJson {
    
    struct alerts {
        
        static let withSingleServiceImpacted = """
        {
          "CTAAlerts": {
            "Alert": [
              {
                "Headline": "headline",
                "ShortDescription": "short description",
                "SeverityScore": "50",
                "Impact": "Minor delays",
                "ImpactedService": {
                  "Service": {
                    "ServiceType": "R",
                    "ServiceId": "Red"
                  }
                }
              }
            ]
          }
        }
        """
        
        static let withMultipleServicesImpacted = """
        {
          "CTAAlerts": {
            "Alert": [
              {
                "Headline": "headline",
                "ShortDescription": "short description",
                "SeverityScore": "65",
                "Impact": "Major delays",
                "ImpactedService": {
                  "Service": [
                    {
                      "ServiceType": "T",
                      "ServiceId": "40510"
                    },
                    {
                      "ServiceType": "R",
                      "ServiceId": "Red"
                    },
                    {
                      "ServiceType": "R",
                      "ServiceId": "G"
                    }
                  ]
                }
              }
            ]
          }
        }
        """
    }
}

