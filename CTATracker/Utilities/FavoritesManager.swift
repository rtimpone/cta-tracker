//
//  FavoritesManager.swift
//  CTATracker
//
//  Created by Rob Timpone on 3/14/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CTAKit
import Foundation

fileprivate protocol FavoritesManager {
    
    associatedtype FavoriteType
    static var key: String { get }
    
    static func fetchFavorites() -> [FavoriteType]
    static func isFavorite(_ object: FavoriteType) -> Bool
    static func addToFavorites(_ object: FavoriteType)
    static func removeFromFavorites(_ object: FavoriteType)
    static func defaultFavorites() -> [FavoriteType]
}

extension FavoritesManager where FavoriteType: Equatable {
    
    static func fetchFavorites() -> [FavoriteType] {
        return UserDefaultsClient.fetchArray(forKey: key) as? [FavoriteType] ?? defaultFavorites()
    }
    
    static func isFavorite(_ object: FavoriteType) -> Bool {
        let favorites = fetchFavorites()
        return favorites.contains(object)
    }
    
    static func addToFavorites(_ object: FavoriteType) {
        var favorites = fetchFavorites()
        if !favorites.contains(object) {
            favorites.append(object)
        }
        UserDefaultsClient.setArray(favorites, forKey: key)
    }
    
    static func removeFromFavorites(_ object: FavoriteType) {
        var favorites = fetchFavorites()
        favorites.removeAll(where: { $0 == object })
        UserDefaultsClient.setArray(favorites, forKey: key)
    }
}

struct FavoriteRoutesManager: FavoritesManager {
    
    typealias FavoriteType = String
    static let key = "favoriteRouteIds"
    
    static func fetchFavoriteRouteIds() -> [String] {
        return fetchFavorites()
    }
    
    static func routeIsFavorite(_ route: Route) -> Bool {
        return isFavorite(route.id)
    }
    
    static func addRouteToFavorites(_ route: Route) {
        addToFavorites(route.id)
    }
    
    static func removeRouteFromFavorites(_ route: Route) {
        removeFromFavorites(route.id)
    }
    
    static func defaultFavorites() -> [String] {
        
        // Red Line, Brown Line, Purple Line
        return ["Red", "Brn", "P"]
    }
}

struct FavoriteStopsManager: FavoritesManager {
    
    typealias FavoriteType = Int
    static let key = "favoriteStopIds"
    
    static func fetchFavoriteStopIds() -> [Int] {
        return fetchFavorites()
    }
    
    static func stopIsFavorite(_ stop: Stop) -> Bool {
        return isFavorite(stop.id)
    }
    
    static func addStopToFavorites(_ stop: Stop) {
        addToFavorites(stop.id)
    }
    
    static func removeStopFromFavorites(_ stop: Stop) {
        removeFromFavorites(stop.id)
    }
    
    static func defaultFavorites() -> [Int] {
        
        // Adams/Wabash (Northbound), Belmont, Damen (Loop-bound), Morse (95th-bound), Monroe (Howard-bound)
        return [30131, 41320, 30019, 30021, 30211]
    }
}
