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
            return tableView.dequeueReusableCell(ofType: StatusErrorCell.self)
        case .initialState:
            return tableView.dequeueReusableCell(ofType: StatusInitialStateCell.self)
        }
    }
}
