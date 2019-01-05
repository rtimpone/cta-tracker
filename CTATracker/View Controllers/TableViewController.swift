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

enum DataSource<T> {
    case data([T])
    case initialState
    case error
}

protocol TableViewDelegate: class {
    func refreshControlWasActivated()
}

class TableViewController: UITableViewController {
    
    private var linesDataSource: DataSource<TrainLine> = .initialState
    weak var delegate: TableViewDelegate?
    
    func displayTrainLines(_ lines: [TrainLine]) {
        linesDataSource = DataSource.data(lines)
        stopRefreshControlAndReloadSection(Sections.statuses)
    }
    
    func displayTrainLinesError() {
        linesDataSource = DataSource.error
        stopRefreshControlAndReloadSection(Sections.statuses)
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
        switch indexPath.section {
        case Sections.statuses:
            return CellFactory.statusCellForRow(at: indexPath, in: tableView, dataSource: linesDataSource)
        case Sections.arrivals:
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case Sections.statuses:
            return SectionHeader.fromNib(withText: "Route Status")
        case Sections.arrivals:
            return SectionHeader.fromNib(withText: "Arrivals")
        default:
            return nil
        }
    }
}

private extension TableViewController {
    
    func stopRefreshControlAndReloadSection(_ section: Int) {
        
        if let control = refreshControl, control.isRefreshing {
            refreshControl?.endRefreshing()
        }
        
        let indexSet = IndexSet(integer: section)
        tableView.reloadSections(indexSet, with: .automatic)
    }
    
    func numberOfRows(forLinesDataSource dataSource: DataSource<TrainLine>) -> Int {
        switch linesDataSource {
        case .data(let lines):
            return lines.count
        case .initialState, .error:
            return 1
        }
    }
}
