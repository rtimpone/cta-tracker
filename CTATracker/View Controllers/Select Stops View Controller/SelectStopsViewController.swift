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
    
    static func instance(withDelegate delegate: SelectStopsViewControllerDelegate) -> SelectStopsViewController {
        let vc = SelectStopsViewController.instantiateFromStoryboard()
        vc.delegate = delegate
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let stations = StationDataFetcher.fetchAllStations()
        let sortedStations = stations.sorted(by: { $0.name < $1.name })
        tableViewController.displayStations(sortedStations)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tvc = segue.destination as? SelectStopsTableViewController {
            tableViewController = tvc
            tvc.delegate = self
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
