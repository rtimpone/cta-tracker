//
//  HomeTableViewController.swift
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
            //need to return at least one row to handle empty state cell
            return max(objects.count, 1)
        case .initialState, .error:
            return 1
        }
    }
}

protocol HomeTableViewControllerDelegate: class {
    func refreshControlWasActivated()
    func didSelectStatus(_ status: RouteStatus)
    func didSelectArrivals(_ arrivals: StopArrivals)
    func didSelectEditRoutes()
    func didSelectEditStops()
}

class HomeTableViewController: UITableViewController {
    
    weak var delegate: HomeTableViewControllerDelegate?
    private var arrivalsDataSource: DataSource<StopArrivals> = .initialState
    private var statusDataSource: DataSource<RouteStatus> = .initialState
    var currentTheme: Theme!
    
    func displayRouteStatuses(_ statuses: [RouteStatus]) {
        setRoutesDataSource(to: statuses)
        stopRefreshControlAndReloadData()
    }
    
    func displayRoutesStatusError() {
        statusDataSource = DataSource.error
        stopRefreshControlAndReloadData()
    }
    
    func displayArrivals(_ arrivals: [StopArrivals]) {
        arrivalsDataSource = DataSource.data(arrivals)
        stopRefreshControlAndReloadData()
    }
    
    func displayArrivalsError() {
        arrivalsDataSource = DataSource.error
        stopRefreshControlAndReloadData()
    }
    
    func addPlaceholderRouteStatus(for route: Route) {
        guard case .data(var statuses) = statusDataSource else {
            return
        }
        let placeholder = RouteStatus(route: route, alerts: [])
        statuses.append(placeholder)
        setRoutesDataSource(to: statuses)
        refreshSection(Sections.statuses)
    }
    
    func removeRouteStatus(for route: Route) {
        guard case .data(var statuses) = statusDataSource else {
            return
        }
        statuses.removeAll() { $0.route.id == route.id }
        setRoutesDataSource(to: statuses)
        refreshSection(Sections.statuses)
    }
    
    func addPlaceholderArrivals(for stop: Stop) {
        guard case .data(var arrivals) = arrivalsDataSource else {
            return
        }
        let placeholder = StopArrivals.emptyArrivals(for: stop)
        arrivals.append(placeholder)
        arrivalsDataSource = .data(arrivals)
        refreshSection(Sections.arrivals)
    }
    
    func removeArrivals(for stop: Stop) {
        guard case .data(var arrivals) = arrivalsDataSource else {
            return
        }
        arrivals.removeAll { $0.stop.id == stop.id }
        arrivalsDataSource = .data(arrivals)
        refreshSection(Sections.arrivals)
    }
    
    @IBAction func refreshControlActivated(_ sender: UIRefreshControl) {
        //need to wait for startRefreshing animation to finish before alerting delegate
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.delegate?.refreshControlWasActivated()
        }
    }
    
    func setRoutesDataSource(to statuses: [RouteStatus]) {
        let sortedStatuses = statuses.sorted(by: { $0.route.title < $1.route.title })
        statusDataSource = DataSource.data(sortedStatuses)
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
            return CellFactory.statusCellForRow(at: indexPath, in: tableView, dataSource: statusDataSource, theme: currentTheme)
        case Sections.arrivals:
            return CellFactory.arrivalsCellForRow(at: indexPath, in: tableView, dataSource: arrivalsDataSource, theme: currentTheme)
        default:
            return UITableViewCell()
        }
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case Sections.statuses:
            let header = tableView.dequeueReusableHeader(ofType: HomeSectionHeader.self)
            header.configure(withText: "Route Status", theme: currentTheme, inSection: section, delegate: self)
            return header
        case Sections.arrivals:
            let header = tableView.dequeueReusableHeader(ofType: HomeSectionHeader.self)
            header.configure(withText: "Arrivals", theme: currentTheme, inSection: section, delegate: self)
            return header
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

extension HomeTableViewController: Themeable {
    
    func applyTheme(_ theme: Theme) {
        currentTheme = theme
        tableView.backgroundColor = theme.tableTheme.backgroundColor
        tableView.reloadData()
    }
}

private extension HomeTableViewController {
    
    func stopRefreshControlAndReloadData() {
        
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
    
    func refreshSection(_ section: Int) {
        let indexSet = IndexSet(integer: section)
        tableView.reloadSections(indexSet, with: .none)
    }
}

extension HomeTableViewController: HomeSectionHeaderDelegate {
    
    func didSelectHeader(inSection section: Int) {
        switch section {
            case Sections.statuses:
            delegate?.didSelectEditRoutes()
        case Sections.arrivals:
            delegate?.didSelectEditStops()
        default:
            break
        }
    }
}
