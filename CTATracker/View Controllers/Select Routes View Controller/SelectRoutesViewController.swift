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
    func didUpdateFavoriteRoutes()
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
        tableViewController.displayRoutes(routes)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
        }
        else {
            FavoriteRoutesManager.addRouteToFavorites(route)
        }
        
        tableViewController.refreshRoutes()
        delegate?.didUpdateFavoriteRoutes()
    }
}
