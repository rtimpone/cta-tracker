//
//  StationRequestHandler.swift
//  CTATracker
//
//  Created by Rob Timpone on 2/27/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CTAKit

class StationRequestHandler: RequestHandler {
    
    func requestUpdatedArrivalTimes(forStop stop: Stop, completion: @escaping (RequestHandlerResult<StopArrivals>) -> Void) {
        client.getArrivals(forStop: stop) { result in
            switch result {
            case .success(let arrivals):
                completion(.success(arrivals))
            case .failure:
                completion(.error)
            }
        }
    }
}
