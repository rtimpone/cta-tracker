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
    func cellForStop(_ stop: Stop, in tableView: UITableView) -> UITableViewCell
    func didSelectStop(_ stop: Stop)
}

class SelectStopsViewController: UIViewController {
    
    weak var delegate: SelectStopsViewControllerDelegate!
    weak var filterViewController: RouteColorFilterViewController!
    weak var tableViewController: SelectStopsTableViewController!
    let hapticsManager = HapticsManager()
    let allStations = StationDataFetcher.fetchAllStations()
    @IBOutlet weak var navBarBackdropView: UIView!
    
    var searchBar: UISearchBar? {
        return parent?.navigationItem.searchController?.searchBar
    }
    
    static func instance(withDelegate delegate: SelectStopsViewControllerDelegate) -> SelectStopsViewController {
        let vc = SelectStopsViewController.instantiateFromStoryboard()
        vc.delegate = delegate
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        applyCurrentTheme()
        refreshStationsBeingShown()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: self)
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
    
    func cellForStop(_ stop: Stop, in tableView: UITableView) -> UITableViewCell {
        return delegate.cellForStop(stop, in: tableView)
    }
    
    func didSelectStop(_ stop: Stop) {
        delegate.didSelectStop(stop)
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

extension SelectStopsViewController: Themeable {
    
    func applyTheme(_ theme: Theme) {
        view.backgroundColor = theme.backgroundTheme.backgroundColor
        navBarBackdropView.backgroundColor = theme.navBarTheme.backdropColor
        searchBar?.tintColor = theme.searchBarTheme.tintColor
        
        switch theme.searchBarTheme.keyboardStyle {
        case .light:
            searchBar?.keyboardAppearance = .light
        case .dark:
            searchBar?.keyboardAppearance = .dark
        }
        
        filterViewController.applyTheme(theme)
        tableViewController?.applyTheme(theme)
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
        
        let availableStations = stationsNotBeingFilteredOut()

        let searchText = textFromSearchBar()
        let searchTextWithWhitespaceTrimmed = searchText.trimmingCharacters(in: .whitespaces)
        guard !searchTextWithWhitespaceTrimmed.isEmpty else {
            tableViewController.displayStations(availableStations)
            return
        }
        
        let searchFilteredStations = stationsMatchingSearchText(searchTextWithWhitespaceTrimmed, in: availableStations)
        tableViewController.displayStations(searchFilteredStations)
    }
    
    func setupSearchController() {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.searchBar.showsCancelButton = false
        sc.hidesNavigationBarDuringPresentation = true
        sc.obscuresBackgroundDuringPresentation = false
        setSearchController(sc)
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
    
    func textFromSearchBar() -> String {
        return searchBar?.text ?? ""
    }
    
    func setSearchController(_ searchController: UISearchController) {
        parent?.navigationItem.searchController = searchController
    }
}
