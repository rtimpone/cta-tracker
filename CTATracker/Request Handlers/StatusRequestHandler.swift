//
//  StatusRequestHandler.swift
//  CTATracker
//
//  Created by Rob Timpone on 2/27/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CTAKit

class StatusRequestHandler: RequestHandler {
    
    var isRequesting = false
    
    func requestTrainStatus(completion: @escaping (RequestHandlerResult<[RouteStatus]>) -> Void) {
        
        if isRequesting {
            print("Status requests are already in flight, wait until requests are finished before starting again")
            return
        }
        
        isRequesting = true
        
        let favoriteRouteIds = FavoritesManager.fetchFavoriteRouteIds()
        let routesToShow = RouteDataFetcher.fetchAllRoutes().filter { favoriteRouteIds.contains($0.id) }
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
