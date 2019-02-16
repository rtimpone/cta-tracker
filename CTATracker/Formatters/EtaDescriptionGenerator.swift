//
//  EtaDescriptionGenerator.swift
//  CTATracker
//
//  Created by Rob Timpone on 2/16/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CTAKit

class EtaDescriptionGenerator {
    
    static func string(for eta: ETA) -> String {
        let secondsUntilArrival = eta.arrivalTime.timeIntervalSinceNow
        let roundedSeconds = Int(secondsUntilArrival.rounded())
        return "\(roundedSeconds)"
    }
}
