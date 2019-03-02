//
//  ArrivalsRequestHandler.swift
//  CTATracker
//
//  Created by Rob Timpone on 2/27/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CTAKit

class ArrivalsRequestHandler: RequestHandler {
    
    var isRequesting = false
    
    func requestTrainStopArrivalTimes(completion: @escaping (RequestHandlerResult<[StopArrivals]>) -> Void) {
        
        if isRequesting {
            print("Arrival requests are already in flight, wait until requests are finished before starting again")
            return
        }
        
        isRequesting = true
        
        // Adams/Wabash (Northbound), Belmont, Damen (Loop-bound), Morse (95th-bound), Monroe (Howard-bound)
        let favoriteStopIds = [30131, 41320, 30019, 30021, 30211]
        
        var stopsToShow: [Stop] = []
        for station in StationDataFetcher.fetchAllStations() {
            if favoriteStopIds.contains(station.id) {
                stopsToShow.append(station)
            }
            else {
                for platform in station.platforms {
                    if favoriteStopIds.contains(platform.id) {
                        stopsToShow.append(platform)
                    }
                }
            }
        }
        
        var allArrivals: [StopArrivals] = []
        var queueCount = stopsToShow.count
        
        for stop in stopsToShow {
            client.getArrivals(forStop: stop) { result in
                
                queueCount -= 1
                
                switch result {
                case .success(let arrivals):
                    allArrivals.append(arrivals)
                    if queueCount == 0 {
                        let sortedArrivals = allArrivals.sorted(by: { $0.stop.name < $1.stop.name })
                        self.isRequesting = false
                        completion(.success(sortedArrivals))
                    }
                case .failure:
                    if queueCount == 0 {
                        self.isRequesting = false
                        completion(.error)
                    }
                }
            }
        }
    }
}
