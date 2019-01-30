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
    
    var numberOfRows: Int {
        switch self {
        case .data(let objects):
            return objects.count
        case .initialState, .error:
            return 1
        }
    }
}

protocol TableViewControllerDelegate: class {
    func refreshControlWasActivated()
    func didSelectStatus(_ status: RouteStatus)
    func didSelectArrivals(_ arrivals: StationArrivals)
}

class TableViewController: UITableViewController {
    
    private var arrivalsDataSource: DataSource<StationArrivals> = .initialState
    private var statusDataSource: DataSource<RouteStatus> = .initialState
    weak var delegate: TableViewControllerDelegate?
    
    func displayRouteStatuses(_ statuses: [RouteStatus]) {
        statusDataSource = DataSource.data(statuses)
        stopRefreshControlAndReloadSection(Sections.statuses)
    }
    
    func displayRoutesStatusError() {
        statusDataSource = DataSource.error
        stopRefreshControlAndReloadSection(Sections.statuses)
    }
    
    func displayArrivals(_ arrivals: [StationArrivals]) {
        arrivalsDataSource = DataSource.data(arrivals)
        stopRefreshControlAndReloadSection(Sections.arrivals)
    }
    
    func displayArrivalsError() {
        arrivalsDataSource = DataSource.error
        stopRefreshControlAndReloadSection(Sections.arrivals)
    }
    
    @IBAction func refreshControlActivated(_ sender: UIRefreshControl) {
        //need to wait for startRefreshing animation to finish before alerting delegate
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.delegate?.refreshControlWasActivated()
        }
    }
    
    // MARK: Table View Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Sections.statuses:
            return statusDataSource.numberOfRows
        case Sections.arrivals:
            return arrivalsDataSource.numberOfRows
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 42
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case Sections.statuses:
            return CellFactory.statusCellForRow(at: indexPath, in: tableView, dataSource: statusDataSource)
        case Sections.arrivals:
            return CellFactory.arrivalsCellForRow(at: indexPath, in: tableView, dataSource: arrivalsDataSource)
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
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: 0.01, height: 0.01))
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case Sections.statuses:
            if case .data(let statuses) = statusDataSource {
                let status = statuses[indexPath.row]
                delegate?.didSelectStatus(status)
            }
        case Sections.arrivals:
            if case .data(let arrivals) = arrivalsDataSource {
                let arrival = arrivals[indexPath.row]
                delegate?.didSelectArrivals(arrival)
            }
        default:
            break
        }
    }
}

private extension TableViewController {
    
    func stopRefreshControlAndReloadSection(_ section: Int) {
        
        let isRefreshing = refreshControl?.isRefreshing ?? false
        if isRefreshing {
            
            //had to play around with the timing of these calls to avoid jumpiness when stopping the refresh control
            let delay = 0.3
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.refreshControl?.endRefreshing()
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + delay + 0.1) {
                self.tableView.reloadData()
            }
        }
        else {
            tableView.reloadData()
        }
    }
}
