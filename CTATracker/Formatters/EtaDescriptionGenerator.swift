//
//  EtaDescriptionGenerator.swift
//  CTATracker
//
//  Created by Rob Timpone on 2/16/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CTAKit

class EtaDescriptionGenerator {
    
    static func stringForTrainArrivingInSeconds(_ secondsUntilArrival: Int) -> String {
        
        if secondsUntilArrival == 0 {
            return "Now"
        }
        
        let secondsComponent = abs(secondsUntilArrival % 60)
        let minutesComponent = abs(secondsUntilArrival / 60)
        let timeDescription = self.timeDescription(forSeconds: secondsComponent, minutes: minutesComponent)
        
        return secondsUntilArrival > 0 ? timeDescription : "Late by \(timeDescription)"
    }
}

private extension EtaDescriptionGenerator {
    
    static func timeDescription(forSeconds seconds: Int, minutes: Int) -> String {
        if minutes > 0 {
            let secondsWithZeroPadding = String(format: "%02d", seconds)
            return "\(minutes)m \(secondsWithZeroPadding)s"
        }
        else {
            return "\(seconds)s"
        }
    }
}
