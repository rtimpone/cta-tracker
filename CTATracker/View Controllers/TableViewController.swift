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
    case initialState
    case error
}

protocol TableViewDelegate: class {
    func refreshControlWasActivated()
}

class TableViewController: UITableViewController {
    
    private var linesDataSource: LineStatusDataSource = .initialState
    weak var delegate: TableViewDelegate?
    
    func display(lines: [TrainLine]) {
        linesDataSource = LineStatusDataSource.lines(lines)
        stopRefreshControlAndReloadData()
    }
    
    func showErrorForLines() {
        linesDataSource = LineStatusDataSource.error
        stopRefreshControlAndReloadData()
    }
    
    @IBAction func refreshControlActivated(_ sender: UIRefreshControl) {
        delegate?.refreshControlWasActivated()
    }
    
    // MARK: Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == Sections.statuses {
            return numberOfRows(forLinesDataSource: linesDataSource)
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 42
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == Sections.statuses {
            return statusCellForRow(at: indexPath, in: tableView, dataSource: linesDataSource)
        }
        
        return UITableViewCell()
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = SectionHeader.fromNib()
        
        switch section {
        case Sections.statuses:
            header.label.text = "Route Status"
        case Sections.arrivals:
            header.label.text = "Arrivals"
        default:
            header.label.text = ""
        }
        
        return header
    }
}

private extension TableViewController {
    
    func stopRefreshControlAndReloadData() {
        let shouldStopRefreshing = refreshControl?.isRefreshing ?? false
        if shouldStopRefreshing {
            refreshControl?.endRefreshing()
        }
        tableView.reloadData()
    }
    
    func numberOfRows(forLinesDataSource dataSource: LineStatusDataSource) -> Int {
        switch linesDataSource {
        case .lines(let lines):
            return lines.count
        case .initialState, .error:
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
        case .error:
            return tableView.dequeueReusableCell(ofType: StatusErrorCell.self)
        case .initialState:
            return tableView.dequeueReusableCell(ofType: StatusInitialStateCell.self)
        }
    }
}
