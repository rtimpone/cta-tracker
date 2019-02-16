//
//  RequestHandlers.swift
//  CTATracker
//
//  Created by Rob Timpone on 1/5/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CTAKit
import Foundation

enum RequestHandlerResult<T> {
    case success(T)
    case error
}

class RequestHandler {
    let client = CtaClient()
}

class ArrivalsRequestHandler: RequestHandler {
    
    var isRequesting = false
    
    func requestTrainStopArrivalTimes(completion: @escaping (RequestHandlerResult<[StopArrivals]>) -> Void) {
        
        if isRequesting {
            print("Arrival requests are already in flight, wait until requests are finished before starting again")
            return
        }
        
        isRequesting = true
        
        let stopNames = [
            "Adams/Wabash (Northbound)",
            "Belmont",
            "Damen (Loop-bound)",
            "Morse (95th-bound)",
            "Monroe (Howard-bound)"
        ]
        
        var stopsToShow: [Stop] = []
        for station in StationDataFetcher.fetchAllStations() {
            if stopNames.contains(station.name) {
                stopsToShow.append(station)
            }
            else {
                for platform in station.platforms {
                    if stopNames.contains(platform.name) {
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
                case .failure(let error):
                    print(error)
                    if queueCount == 0 {
                        self.isRequesting = false
                        completion(.error)
                    }
                }
            }
        }
    }
}

class StatusRequestHandler: RequestHandler {
    
    let selectedRoutes = ["Red Line", "Brown Line", "Purple Line"]
    var isRequesting = false
    
    func requestTrainStatus(completion: @escaping (RequestHandlerResult<[RouteStatus]>) -> Void) {
        
        if isRequesting {
            print("Status requests are already in flight, wait until requests are finished before starting again")
            return
        }
        
        isRequesting = true
        
        let routesToShow = RouteDataFetcher.fetchAllRoutes().filter { self.selectedRoutes.contains($0.title) }
        client.getStatuses(for: routesToShow) { result in
            
            switch result {
            case .success(let statuses):
                self.isRequesting = false
                completion(.success(statuses))
                
            case .failure:
                self.isRequesting = false
                completion(.error)
            }
        }
    }
}
