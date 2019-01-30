//
//  CTAClient.swift
//  CTAKit
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import Foundation

public class CtaClient: ApiClient {

    public func getStatuses(for routes: [Route], completion: @escaping (ApiResult<[RouteStatus]>) -> Void) {
        let routeIds = routes.map{ $0.id }.joined(separator: ",")
        let url = URL(string: "http://www.transitchicago.com/api/1.0/alerts.aspx?routeid=\(routeIds)&outputType=JSON")!
        fetchObject(ofType: AlertsContainerResponse.self, from: url) { result in
            switch result {
            case .success(let alertsContainer):
                let alertResponses = alertsContainer.root.alerts
                let alerts = alertResponses.map{ Alert(from: $0) }
                let statuses = self.routeStatusesFor(routes: routes, with: alerts)
                completion(.success(statuses))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func getArrivals(forStop stop: TrainStop, completion: @escaping (ApiResult<StationArrivals>) -> Void) {

        var params = ["key": Credentials.apiKey, "outputType": "JSON"]
        switch stop.type {
        case .platform:
            params["stpid"] = "\(stop.id)"
        case .station:
            params["mapid"] = "\(stop.id)"
        }
        
        let baseURL = "http://lapi.transitchicago.com/api/1.0/ttarrivals.aspx"
        
        let url = URL(string: baseURL, parameters: params)!
        fetchObject(ofType: ArrivalsContainerResponse.self, from: url) { result in
            switch result {
            case .success(let container):
                let responses = container.root.etas
                guard let arrivals = StationArrivals(from: responses, for: stop) else {
                    completion(.failure(.invalidData))
                    return
                }
                completion(.success(arrivals))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

private extension CtaClient {
    
    func routeStatusesFor(routes: [Route], with alerts: [Alert]) -> [RouteStatus] {
        let alertsByRoute = self.alertsForRouteDictionary(from: alerts)
        let statuses = routes.map { route -> RouteStatus in
            let alerts = alertsByRoute[route] ?? []
            return RouteStatus(route: route, alerts: alerts)
        }
        return statuses
    }
    
    func alertsForRouteDictionary(from alerts: [Alert]) -> [Route: [Alert]] {
        let alertsForRouteDictionary = alerts.reduce(into: [Route: [Alert]]()) { (dictionary, alert) in
            for route in alert.routesImpacted {
                var alertsForRoute = dictionary[route] ?? []
                alertsForRoute.append(alert)
                dictionary[route] = alertsForRoute
            }
        }
        return alertsForRouteDictionary
    }
}
