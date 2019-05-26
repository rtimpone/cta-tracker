//
//  SelectStopsViewController.swift
//  CTATracker
//
//  Created by Rob Timpone on 3/15/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CTAKit
import UIKit

protocol SelectStopsViewControllerDelegate: class {
    func didAddStopToFavorites(_ stop: Stop)
    func didRemoveStopsFromFavorites(_ stop: Stop)
}

class SelectStopsViewController: UIViewController {
    
    weak var filterViewController: RouteColorFilterViewController!
    weak var tableViewController: SelectStopsTableViewController!
    weak var delegate: SelectStopsViewControllerDelegate?
    let hapticsManager = HapticsManager()
    
    let allStations = StationDataFetcher.fetchAllStations().sorted(by: { $0.name < $1.name })
    
    static func instance(withDelegate delegate: SelectStopsViewControllerDelegate) -> SelectStopsViewController {
        let vc = SelectStopsViewController.instantiateFromStoryboard()
        vc.delegate = delegate
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshStationsBeingShown()
        setupSearchController()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tvc = segue.destination as? SelectStopsTableViewController {
            tableViewController = tvc
            tvc.delegate = self
        }
        else if let rcfvc = segue.destination as? RouteColorFilterViewController {
            filterViewController = rcfvc
            rcfvc.delegate = self
        }
    }
}

extension SelectStopsViewController: SelectStopsTableViewControllerDelegate {
    
    func stopIsSelected(_ stop: Stop) -> Bool {
        return FavoriteStopsManager.stopIsFavorite(stop)
    }
    
    func didSelectStop(_ stop: Stop) {
        
        hapticsManager.fireSelectionHaptic()
        
        if FavoriteStopsManager.stopIsFavorite(stop) {
            FavoriteStopsManager.removeStopFromFavorites(stop)
            delegate?.didRemoveStopsFromFavorites(stop)
        }
        else {
            FavoriteStopsManager.addStopToFavorites(stop)
            delegate?.didAddStopToFavorites(stop)
        }
        
        tableViewController.refreshStops()
    }
}

extension SelectStopsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        refreshStationsBeingShown()
    }
}

extension SelectStopsViewController: RouteColorFilterViewControllerDelegate {
    
    func didUpdateRouteFilters(_ routesToShow: Set<Route>) {
        hapticsManager.fireSelectionHaptic()
        refreshStationsBeingShown()
    }
}

private extension SelectStopsViewController {
    
    func stationsNotBeingFilteredOut() -> [Station] {
        
        let routesToShow = filterViewController.selectedRoutes
        
        guard !routesToShow.isEmpty else {
            return allStations
        }
        
        let stations = allStations.filter { station in
            for platform in station.platforms {
                for route in platform.routes {
                    if routesToShow.contains(route) {
                        return true
                    }
                }
            }
            return false
        }
        return stations
    }
    
    func refreshStationsBeingShown() {
        
        let availableStations = stationsNotBeingFilteredOut().sorted(by: { $0.name < $1.name })
        
        guard let searchText = navigationItem.searchController?.searchBar.text, !searchText.isEmpty else {
            tableViewController.displayStations(availableStations)
            return
        }
        
        let searchFilteredStations = stationsMatchingSearchText(searchText, in: availableStations)
        tableViewController.displayStations(searchFilteredStations)
    }
    
    func setupSearchController() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.showsCancelButton = false
        search.hidesNavigationBarDuringPresentation = true
        search.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = search
    }
    
    func stationsMatchingSearchText(_ searchText: String, in stations: [Station]) -> [Station] {
        let filteredStations = stations.filter { station in
            if station.name.contains(searchText) {
                return true
            }
            for platform in station.platforms {
                if platform.platformDescription.contains(searchText) {
                    return true
                }
            }
            return false
        }
        return filteredStations
    }
}
