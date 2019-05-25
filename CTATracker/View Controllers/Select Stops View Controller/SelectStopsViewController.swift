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
    
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var colorsView: UIView!
    @IBOutlet weak var overlayButton: UIButton!
    
    static func instance(withDelegate delegate: SelectStopsViewControllerDelegate) -> SelectStopsViewController {
        let vc = SelectStopsViewController.instantiateFromStoryboard()
        vc.delegate = delegate
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewController.displayStations(allStations)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tvc = segue.destination as? SelectStopsTableViewController {
            tableViewController = tvc
            tvc.delegate = self
        }
    }
    
    @IBAction func searchAction(_ sender: UIBarButtonItem) {
        
        filterView.bringSubviewToFront(searchView)
        searchBar.becomeFirstResponder()
        
        overlayButton.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            self.overlayButton.alpha = 1
        }) { finished in
            
        }
    }
    
    @IBAction func overlayAction(_ sender: UIButton) {
        filterView.sendSubviewToBack(searchView)
        searchBar.resignFirstResponder()
        
        
        UIView.animate(withDuration: 0.3, animations: {
            self.overlayButton.alpha = 0
        }) { finished in
            self.overlayButton.isHidden = true
        }
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

extension SelectStopsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
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
