//
//  CellFactory.swift
//  CTATracker
//
//  Created by Rob Timpone on 1/5/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import AutoRegistering
import CTAKit
import UIKit

class CellFactory {
    
    static func statusCellForRow(at indexPath: IndexPath, in tableView: UITableView, dataSource: DataSource<RouteStatus>) -> UITableViewCell {
        
        switch dataSource {
        case .data(let statuses):
            
            guard statuses.count > 0 else {
                return dequeueGenericMessageCell(in: tableView, withText: "No routes selected")
            }
            
            let status = statuses[indexPath.row]
            let cell = tableView.dequeueReusableCell(ofType: StatusCell.self)
            cell.configure(for: status)
            return cell
            
        case .error:
            return dequeueGenericMessageCell(in: tableView, withText: "Unable to get status for CTA routes")
            
        case .initialState:
            return dequeueGenericMessageCell(in: tableView, withText: "Getting status data for CTA routes...")
        }
    }
    
    static func arrivalsCellForRow(at indexPath: IndexPath, in tableView: UITableView, dataSource: DataSource<StopArrivals>) -> UITableViewCell {
        
        switch dataSource {
        case .data(let arrivals):
            
            guard arrivals.count > 0 else {
                return dequeueGenericMessageCell(in: tableView, withText: "No stops selected")
            }
            
            let arrival = arrivals[indexPath.row]
            let isLocationBased = !FavoriteStopsManager.stopIsFavorite(arrival.stop)
            let cell = tableView.dequeueReusableCell(ofType: ArrivalCell.self)
            cell.configure(for: arrival, isLocationBased: isLocationBased)
            return cell
            
        case .error:
            return dequeueGenericMessageCell(in: tableView, withText: "Unable to get data for CTA arrivals")
            
        case .initialState:
            return dequeueGenericMessageCell(in: tableView, withText: "Getting data for CTA arrivals...")
        }
    }
}

private extension CellFactory {
    
    static func dequeueGenericMessageCell(in tableView: UITableView, withText text: String) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: GenericMessageCell.self)
        cell.configure(withText: text)
        return cell
    }
}
