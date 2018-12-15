//
//  StatusTableHandler.swift
//  CTATracker
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import CTAKit
import UIKit

class StatusTableHandler: NSObject {
    
    weak var tableView: UITableView!
    private var lines: [TrainLine] = []
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.dataSource = self
    }
    
    func display(lines: [TrainLine]) {
        self.lines = lines
        tableView.reloadData()
    }
}

extension StatusTableHandler: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let status = lines[indexPath.row]
        let cell = tableView.dequeueReusableCell(ofType: StatusCell.self)
        cell.configure(for: status)
        return cell
    }
}
