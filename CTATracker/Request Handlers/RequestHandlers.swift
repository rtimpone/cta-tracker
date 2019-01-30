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
    
    let routesToShow = ["Red Line", "Brown Line", "Purple Line"]
    var isRequesting = false
    
    func requestTrainStatus(completion: @escaping (RequestHandlerResult<[RouteStatus]>) -> Void) {
        
        if isRequesting {
            print("Status requests are already in flight, wait until requests are finished before starting again")
            return
        }
        
        isRequesting = true
        var queueCount = 2
        
        var routes: [RouteStatus] = []
        var trainAlerts: [Alert] = []
        
        client.getTrainLines() { result in
            
            queueCount -= 1
            
            switch result {
            case .success(let routesFromApi):
                
                routes = routesFromApi.filter { self.routesToShow.contains($0.title) }
                
                if queueCount == 0 {
                    self.isRequesting = false
                    let routesWithAlerts = self.updateRoutes(routes, withAlerts: trainAlerts)
                    completion(.success(routesWithAlerts))
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
                    let routesWithAlerts = self.updateRoutes(routes, withAlerts: trainAlerts)
                    completion(.success(routesWithAlerts))
                }
                
            case .failure:
                self.isRequesting = false
                completion(.error)
            }
        }
    }
}

private extension StatusRequestHandler {
    
    func updateRoutes(_ routes: [RouteStatus], withAlerts alerts: [Alert]) -> [RouteStatus] {
        var updatedRoutes: [RouteStatus] = []
        for var route in routes {
            let alertsForThisRoute = alerts.filter { $0.routesImpacted.map({ $0.id }).contains(route.id) }
            route.addAlerts(alertsForThisRoute)
            updatedRoutes.append(route)
        }
        return updatedRoutes
    }
}
