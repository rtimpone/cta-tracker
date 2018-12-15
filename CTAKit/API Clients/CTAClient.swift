//
//  CTAClient.swift
//  CTAKit
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import Foundation

public class CTAClient: APIClient {
    
    public func getTrainLines(completion: @escaping (ApiResult<[TrainLine]>) -> Void) {
        
        let url = URL(string: "http://www.transitchicago.com/api/1.0/routes.aspx?outputType=JSON")!
        fetchObject(ofType: RouteInfoContainer.self, from: url) { result in
            switch result {
            case .success(let infoContainer):
                let routeStatusResponses = infoContainer.info.routeStatusResponses
                let trainStatusResponses = routeStatusResponses.filter { $0.title.range(of: " Line") != nil }
                let trainStatuses = trainStatusResponses.map { TrainLine(fromResponse: $0) }
                completion(.success(trainStatuses))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func getArrivals(completion: @escaping (ApiResult<[Arrival]>) -> Void) {

        let apiKey = ""
        let id = "40680"
        let route = "Brn"
        
        let url = URL(string: "http://lapi.transitchicago.com/api/1.0/ttarrivals.aspx?key=\(apiKey)&mapid=\(id)&rt=\(route)&outputType=JSON")!
        fetchObject(ofType: ArrivalsContainerResponse.self, from: url) { result in
            switch result {
            case .success(let container):
                let arrivalResponses = container.root.etas
                let arrivals = arrivalResponses.compactMap { Arrival(from: $0) }
                completion(.success(arrivals))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
