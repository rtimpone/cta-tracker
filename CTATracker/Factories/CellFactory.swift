//
//  CellFactory.swift
//  CTATracker
//
//  Created by Rob Timpone on 1/5/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CTAKit
import UIKit

class CellFactory {
    
    static func statusCellForRow(at indexPath: IndexPath, in tableView: UITableView, dataSource: DataSource<TrainLine>) -> UITableViewCell {
        
        switch dataSource {
        case .data(let lines):
            let status = lines[indexPath.row]
            let cell = tableView.dequeueReusableCell(ofType: StatusCell.self)
            cell.configure(for: status)
            return cell
            
        case .error:
            return dequeueGenericMessageCell(in: tableView, withText: "Unable to get status for CTA routes")
            
        case .initialState:
            return dequeueGenericMessageCell(in: tableView, withText: "Getting status data for CTA routes...")
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
