//
//  TableViewController.swift
//  CTATracker
//
//  Created by Rob Timpone on 1/5/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CTAKit
import UIKit

struct Sections {
    static let statuses = 0
    static let arrivals = 1
}

enum LineStatusDataSource {
    case lines([TrainLine])
    case requesting
    case error
}

protocol TableViewDelegate: class {
    func refreshControlWasActivated()
}

class TableViewController: UITableViewController {
    
    private var linesDataSource: LineStatusDataSource = .lines([])
    weak var delegate: TableViewDelegate?
    
    func display(lines: [TrainLine]) {
        linesDataSource = LineStatusDataSource.lines(lines)
        refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
    @IBAction func refreshControlActivated(_ sender: UIRefreshControl) {
        delegate?.refreshControlWasActivated()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == Sections.statuses {
            return numberOfRows(forLinesDataSource: linesDataSource)
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == Sections.statuses {
            return statusCellForRow(at: indexPath, in: tableView, dataSource: linesDataSource)
        }
        
        return UITableViewCell()
    }
}

private extension TableViewController {
    
    func numberOfRows(forLinesDataSource dataSource: LineStatusDataSource) -> Int {
        switch linesDataSource {
        case .lines(let lines):
            return lines.count
        case .requesting, .error:
            return 1
        }
    }
    
    func statusCellForRow(at indexPath: IndexPath, in tableView: UITableView, dataSource: LineStatusDataSource) -> UITableViewCell {
        switch linesDataSource {
        case .lines(let lines):
            let status = lines[indexPath.row]
            let cell = tableView.dequeueReusableCell(ofType: StatusCell.self)
            cell.configure(for: status)
            return cell
        case .requesting, .error:
            return UITableViewCell()
        }
    }
}
