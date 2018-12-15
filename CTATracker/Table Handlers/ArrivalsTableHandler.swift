//
//  ArrivalsTableHandler.swift
//  CTATracker
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import CTAKit
import Foundation

class ArrivalsTableHandler: NSObject {
    
    weak var tableView: UITableView!
    private var arrivals: [TrainArrival] = []
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.dataSource = self
    }
    
    func display(arrivalTimes: [TrainArrival]) {
        self.arrivals = arrivalTimes
        tableView.reloadData()
    }
}

extension ArrivalsTableHandler: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrivals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: ArrivalCell.self)
        cell.configure(for: arrivals)
        return cell
    }
}
