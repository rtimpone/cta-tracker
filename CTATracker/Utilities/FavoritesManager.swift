//
//  FavoritesManager.swift
//  CTATracker
//
//  Created by Rob Timpone on 3/14/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CTAKit
import Foundation

struct FavoritesManager {

    // Adams/Wabash (Northbound), Belmont, Damen (Loop-bound), Morse (95th-bound), Monroe (Howard-bound)
    private static let favoriteStopIds = [30131, 41320, 30019, 30021, 30211]
    
    // Red Line, Brown Line, Purple Line
    private static let favoriteRouteIds = ["Red", "Brn", "P"]
    
    static func fetchFavoriteStopIds() -> [Int] {
        return favoriteStopIds
    }
    
    static func fetchFavoriteRouteIds() -> [String] {
        return favoriteRouteIds
    }
    
    static func stopIsFavorite(_ stop: Stop) -> Bool {
        return favoriteStopIds.contains(stop.id)
    }
    
    static func routeIsFavorite(_ route: Route) -> Bool {
        return favoriteRouteIds.contains(route.id)
    }
}
