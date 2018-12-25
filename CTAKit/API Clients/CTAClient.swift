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
    
    public func getArrivals(forStop stop: TrainStop, completion: @escaping (ApiResult<StationArrivals>) -> Void) {

        let params = ["key": Credentials.apiKey,
                      "stpid": "\(stop.id)",
                      "outputType": "JSON"]
        
        let baseURL = "http://lapi.transitchicago.com/api/1.0/ttarrivals.aspx"
        
        let url = URL(string: baseURL, parameters: params)!
        fetchObject(ofType: ArrivalsContainerResponse.self, from: url) { result in
            switch result {
            case .success(let container):
                let responses = container.root.etas
                guard let arrivals = StationArrivals(from: responses) else {
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
