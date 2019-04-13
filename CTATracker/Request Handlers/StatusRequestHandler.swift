//
//  StatusRequestHandler.swift
//  CTATracker
//
//  Created by Rob Timpone on 2/27/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CTAKit

class StatusRequestHandler: RequestHandler {
    
    func requestTrainStatus(completion: @escaping (RequestHandlerResult<[RouteStatus]>) -> Void) {
        
        let favoriteRouteIds = FavoriteRoutesManager.fetchFavoriteRouteIds()
        let routesToShow = RouteDataFetcher.fetchAllRoutes().filter { favoriteRouteIds.contains($0.id) }
        client.getStatuses(for: routesToShow) { result in
            
            switch result {
            case .success(let statuses):
                completion(.success(statuses))
                
            case .failure:
                completion(.error)
            }
        }
    }
}
