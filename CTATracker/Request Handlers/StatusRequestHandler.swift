//
//  StatusRequestHandler.swift
//  CTATracker
//
//  Created by Rob Timpone on 2/27/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CTAKit

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
