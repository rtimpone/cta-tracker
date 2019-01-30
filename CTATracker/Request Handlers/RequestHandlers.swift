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
    
    let linesToShow = ["Red Line", "Brown Line", "Purple Line"]
    var isRequesting = false
    
    func requestTrainStatus(completion: @escaping (RequestHandlerResult<[TrainLine]>) -> Void) {
        
        if isRequesting {
            print("Status requests are already in flight, wait until requests are finished before starting again")
            return
        }
        
        isRequesting = true
        var queueCount = 2
        
        var trainLines: [TrainLine] = []
        var trainAlerts: [Alert] = []
        
        client.getTrainLines() { result in
            
            queueCount -= 1
            
            switch result {
            case .success(let lines):
                
                trainLines = lines.filter { self.linesToShow.contains($0.title) }
                
                if queueCount == 0 {
                    self.isRequesting = false
                    let linesWithAlerts = self.updateLines(trainLines, withAlerts: trainAlerts)
                    completion(.success(linesWithAlerts))
                }
                
            case .failure(_):
                self.isRequesting = false
                completion(.error)
            }
        }
        
        client.getAlerts() { result in
            
            queueCount -= 1
            
            switch result {
            case .success(let alerts):
                
                trainAlerts = alerts
                
                if queueCount == 0 {
                    self.isRequesting = false
                    let linesWithAlerts = self.updateLines(trainLines, withAlerts: trainAlerts)
                    completion(.success(linesWithAlerts))
                }
                
            case .failure:
                self.isRequesting = false
                completion(.error)
            }
        }
    }
}

private extension StatusRequestHandler {
    
    func updateLines(_ lines: [TrainLine], withAlerts alerts: [Alert]) -> [TrainLine] {
        var updatedTrainLines: [TrainLine] = []
        for var line in lines {
            let alertsForThisLine = alerts.filter { $0.routesImpacted.map({ $0.id }).contains(line.id) }
            line.addAlerts(alertsForThisLine)
            updatedTrainLines.append(line)
        }
        return updatedTrainLines
    }
}
