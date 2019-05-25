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
    
    weak var tableViewController: SelectStopsTableViewController!
    weak var delegate: SelectStopsViewControllerDelegate?
    let allStations = StationDataFetcher.fetchAllStations().sorted(by: { $0.name < $1.name })
    
    static func instance(withDelegate delegate: SelectStopsViewControllerDelegate) -> SelectStopsViewController {
        let vc = SelectStopsViewController.instantiateFromStoryboard()
        vc.delegate = delegate
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewController.displayStations(allStations)
        setupSearchController()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tvc = segue.destination as? SelectStopsTableViewController {
            tableViewController = tvc
            tvc.delegate = self
        }
        else if let rcfvc = segue.destination as? RouteColorFilterViewController {
            rcfvc.delegate = self
        }
    }
    
    @IBAction func searchAction(_ sender: UIBarButtonItem) {
        navigationItem.searchController?.searchBar.becomeFirstResponder()
    }
}

extension SelectStopsViewController: SelectStopsTableViewControllerDelegate {
    
    func stopIsSelected(_ stop: Stop) -> Bool {
        return FavoriteStopsManager.stopIsFavorite(stop)
    }
    
    func didSelectStop(_ stop: Stop) {
        
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

        guard searchController.isActive, let searchText = searchController.searchBar.text else {
            return
        }
        
        let whiteSpaceRemovedText = searchText.components(separatedBy: .whitespaces).joined()

        if whiteSpaceRemovedText.count == 0 {
            tableViewController.displayStations(allStations)
        }
        else {
            let stations = stationsMatchingSearchText(searchText)
            tableViewController.displayStations(stations)
        }
    }
}

extension SelectStopsViewController: RouteColorFilterViewControllerDelegate {
    
    func didUpdateRouteFilters(_ routesToShow: Set<Route>) {
        print(routesToShow)
    }
}

private extension SelectStopsViewController {
    
    func setupSearchController() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.showsCancelButton = false
        search.hidesNavigationBarDuringPresentation = true
        search.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = search
    }
    
    func stationsMatchingSearchText(_ searchText: String) -> [Station] {
        let filteredStations = allStations.filter { station in
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
        let sortedFilteredStations = filteredStations.sorted(by: { $0.name < $1.name })
        return sortedFilteredStations
    }
}
