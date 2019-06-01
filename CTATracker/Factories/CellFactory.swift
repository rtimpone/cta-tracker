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
    
    static func statusCellForRow(at indexPath: IndexPath, in tableView: UITableView, dataSource: DataSource<RouteStatus>, theme: Theme) -> UITableViewCell {
        
        switch dataSource {
        case .data(let statuses):
            
            guard statuses.count > 0 else {
                return dequeueGenericMessageCell(in: tableView, withText: "No routes selected", theme: theme)
            }
            
            let status = statuses[indexPath.row]
            let cell = tableView.dequeueReusableCell(ofType: StatusCell.self)
            cell.configure(for: status, theme: theme)
            return cell
            
        case .error:
            return dequeueGenericMessageCell(in: tableView, withText: "Unable to get status for CTA routes", theme: theme)
            
        case .initialState:
            return dequeueGenericMessageCell(in: tableView, withText: "Getting status data for CTA routes...", theme: theme)
        }
    }
    
    static func arrivalsCellForRow(at indexPath: IndexPath, in tableView: UITableView, dataSource: DataSource<StopArrivals>, theme: Theme) -> UITableViewCell {
        
        switch dataSource {
        case .data(let arrivals):
            
            guard arrivals.count > 0 else {
                return dequeueGenericMessageCell(in: tableView, withText: "No stops selected", theme: theme)
            }
            
            let arrival = arrivals[indexPath.row]
            let isLocationBased = !FavoriteStopsManager.stopIsFavorite(arrival.stop)
            let cell = tableView.dequeueReusableCell(ofType: ArrivalCell.self)
            cell.configure(for: arrival, isLocationBased: isLocationBased, theme: theme)
            return cell
            
        case .error:
            return dequeueGenericMessageCell(in: tableView, withText: "Unable to get data for CTA arrivals", theme: theme)
            
        case .initialState:
            return dequeueGenericMessageCell(in: tableView, withText: "Getting data for CTA arrivals...", theme: theme)
        }
    }
}

private extension CellFactory {
    
    static func dequeueGenericMessageCell(in tableView: UITableView, withText text: String, theme: Theme) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: GenericMessageCell.self)
        cell.configure(withText: text, theme: theme)
        return cell
    }
}
