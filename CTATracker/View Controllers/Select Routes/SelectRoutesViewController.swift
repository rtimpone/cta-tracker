//
//  SelectRoutesViewController.swift
//  CTATracker
//
//  Created by Rob Timpone on 3/15/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CTAKit
import UIKit

protocol SelectRoutesViewControllerDelegate: class {
    func didAddRouteToFavorites(_ route: Route)
    func didRemoveRouteFromFavorites(_ route: Route)
}

class SelectRoutesViewController: UIViewController {

    weak var tableViewController: SelectRoutesTableViewController!
    weak var delegate: SelectRoutesViewControllerDelegate?
    
    static func instance(withDelegate delegate: SelectRoutesViewControllerDelegate) -> SelectRoutesViewController {
        let vc = SelectRoutesViewController.instantiateFromStoryboard()
        vc.delegate = delegate
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let routes = RouteDataFetcher.fetchAllRoutes()
        let sortedRoutes = routes.sorted(by: { $0.title < $1.title })
        tableViewController.displayRoutes(sortedRoutes)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: self)
        if let tvc = segue.destination as? SelectRoutesTableViewController {
            tableViewController = tvc
            tvc.delegate = self
        }
    }
}

extension SelectRoutesViewController: SelectRoutesTableViewControllerDelegate {
    
    func routeIsSelected(_ route: Route) -> Bool {
        return FavoriteRoutesManager.routeIsFavorite(route)
    }
    
    func didSelectRoute(_ route: Route) {
        
        if FavoriteRoutesManager.routeIsFavorite(route) {
            FavoriteRoutesManager.removeRouteFromFavorites(route)
            delegate?.didRemoveRouteFromFavorites(route)
        }
        else {
            FavoriteRoutesManager.addRouteToFavorites(route)
            delegate?.didAddRouteToFavorites(route)
        }
        
        tableViewController.refreshRoutes()
    }
}
