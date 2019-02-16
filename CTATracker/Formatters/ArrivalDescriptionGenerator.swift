//
//  ArrivalDescriptionGenerator.swift
//  CTATracker
//
//  Created by Rob Timpone on 2/16/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CTAKit

class ArrivalDescriptionGenerator {
    
    static func string(for status: ArrivalStatus, secondsUntilArrival seconds: Int) -> String {
        switch status {
        case .enRoute, .scheduled:
            if seconds < 0 {
                return "Overdue"
            }
            else if seconds < 60 {
                return "Due"
            }
            else if seconds > 60 * 60 {
                return "Over an hour"
            }
            else if seconds == 60 * 60 {
                return "1 hour"
            }
            else {
                return minutesStringForNumberOfSecondsRoundingUp(seconds)
            }
        case .approaching:
            return "Approaching"
        case .delayed:
            return "Delayed"
        case .unavailable:
            return "Unavailable"
        }
    }
}

private extension ArrivalDescriptionGenerator {
    
    static func minutesStringForNumberOfSecondsRoundingUp(_ seconds: Int) -> String {
        let minutesPassed = seconds / 60
        let secondsRemaining = seconds % 60
        let shouldRoundUp = secondsRemaining > 0
        let minutes = shouldRoundUp ? (minutesPassed + 1) : minutesPassed
        return "\(minutes) min"
    }
}
