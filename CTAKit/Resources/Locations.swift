//
//  Locations.swift
//  CTAKit
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import CoreLocation
import Foundation

public class UTCOffsets {
    
    static var chicago = "+0000"
    
    public static func lookupOffsets(completion: @escaping () -> Void) {
        Location.createLocation(latitude: 41.882042, longitude: -87.627819) { location in
            if let offset = location?.utcOffset {
                self.chicago = offset
            }
            completion()
        }
    }
}

class Location {
    
    var utcOffset: String = "+0000"
    
    init(utcOffset: String) {
        self.utcOffset = utcOffset
    }
    
    static func createLocation(latitude: Double, longitude: Double, completion: @escaping (Location?) -> Void) {
        
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(location) { placemarks, error in
            
            guard let placemark = placemarks?.first else {
                print("Unable to get placemarks for lat/long")
                completion(nil)
                return
            }
            
            guard let timeZone = placemark.timeZone else {
                print("Unable to get time zone from placemark")
                completion(nil)
                return
            }
            
            let seconds = timeZone.secondsFromGMT()
            let minutes = seconds / 60
            let hours = minutes / 60
            
            let nf = NumberFormatter()
            nf.minimumIntegerDigits = 4
            
            let nsnumber = NSNumber(integerLiteral: hours * 100)
            if let output = nf.string(from: nsnumber) {
                let location = Location(utcOffset: output)
                completion(location)
            }
        }
    }
}
