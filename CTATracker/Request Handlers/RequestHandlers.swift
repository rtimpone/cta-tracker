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
    
    let stopsToShow = TrainStop.allStops
    var isRequesting = false
    
    func requestTrainStopArrivalTimes(completion: @escaping (RequestHandlerResult<[StationArrivals]>) -> Void) {
        
        if isRequesting {
            print("Arrival requests are already in flight, wait until requests are finished before starting again")
            return
        }
        
        isRequesting = true
        
        var allArrivals: [StationArrivals] = []
        var queueCount = stopsToShow.count
        
        for stop in stopsToShow {
            client.getArrivals(forStop: stop) { result in
                
                queueCount -= 1
                
                switch result {
                case .success(let arrivals):
                    allArrivals.append(arrivals)
                    if queueCount == 0 {
                        let sortedArrivals = allArrivals.sorted(by: { $0.station.name < $1.station.name })
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
    
    let linesToShow = ["Red Line", "Brown Line", "Purple Line"]
    
    func requestTrainStatus(completion: @escaping (RequestHandlerResult<[TrainLine]>) -> Void) {
        
        client.getTrainLines() { result in
            switch result {
            case .success(let lines):
                let filteredLines = lines.filter { self.linesToShow.contains($0.title) }
                completion(.success(filteredLines))
            case .failure(_):
                completion(.error)
            }
        }
    }
}
