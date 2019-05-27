//
//  SelectFavoriteStopsViewController.swift
//  CTATracker
//
//  Created by Rob Timpone on 5/26/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CTAKit
import UIKit

protocol SelectFavoriteStopsViewControllerDelegate: class {
    func didAddStopToFavorites(_ stop: Stop)
    func didRemoveStopsFromFavorites(_ stop: Stop)
}

class SelectFavoriteStopsViewController: UIViewController {
    
    weak var delegate: SelectFavoriteStopsViewControllerDelegate?
    
    static func instance(withDelegate delegate: SelectFavoriteStopsViewControllerDelegate) -> SelectFavoriteStopsViewController {
        let vc = SelectFavoriteStopsViewController.instantiateFromStoryboard()
        vc.delegate = delegate
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = SelectStopsViewController.instance(withDelegate: self)
        add(child: vc)
    }
}

extension SelectFavoriteStopsViewController: SelectStopsViewControllerDelegate {
    
    func cellForStop(_ stop: Stop, in tableView: UITableView) -> UITableViewCell {
        let isSelected = FavoriteStopsManager.stopIsFavorite(stop)
        if let station = stop as? Station {
            let cell = tableView.dequeueReusableCell(ofType: StationCell.self)
            cell.configure(for: station, isSelected: isSelected)
            return cell
        }
        else if let platform = stop as? Platform {
            let cell = tableView.dequeueReusableCell(ofType: PlatformCell.self)
            cell.configure(for: platform, isSelected: isSelected)
            return cell
        }
        else {
            fatalError("Stop is not a station or a platform")
        }
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
    }
}
