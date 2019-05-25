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
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.showsCancelButton = false
        search.hidesNavigationBarDuringPresentation = true
        search.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = search
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tvc = segue.destination as? SelectStopsTableViewController {
            tableViewController = tvc
            tvc.delegate = self
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

        guard searchController.isActive else {
            return
        }
        
        guard let searchText = searchController.searchBar.text else {
            return
        }
        
        let whiteSpaceRemovedText = searchText.components(separatedBy: .whitespaces).joined()

        if whiteSpaceRemovedText.count == 0 {
            tableViewController.displayStations(allStations)
        }
        else {
            let filteredStations = allStations.filter { $0.name.contains(searchText) }
            let sortedFilteredStations = filteredStations.sorted(by: { $0.name < $1.name })
            tableViewController.displayStations(sortedFilteredStations)
        }
    }
}
