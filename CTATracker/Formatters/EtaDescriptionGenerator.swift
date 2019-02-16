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
        
        let minutes = abs(secondsUntilArrival / 60)
        let seconds = abs(secondsUntilArrival % 60)
        let timeDescription = self.timeDescription(forMinutes: minutes, seconds: seconds)
        
        return secondsUntilArrival > 0 ? timeDescription : "Late by \(timeDescription)"
    }
}

private extension EtaDescriptionGenerator {
    
    static func timeDescription(forMinutes minutes: Int, seconds: Int) -> String {
        
        var timeDescription = ""
        
        if minutes == 0 && seconds > 0 {
            timeDescription = "\(seconds)s"
        }
        else if minutes > 0 && seconds == 0 {
            timeDescription = "\(minutes)m"
        }
        else {
            timeDescription = "\(minutes)m \(seconds)s"
        }
        
        return timeDescription
    }
}
