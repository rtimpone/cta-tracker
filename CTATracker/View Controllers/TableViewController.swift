//
//  TableViewController.swift
//  CTATracker
//
//  Created by Rob Timpone on 1/5/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CTAKit
import UIKit

class TableViewController: UITableViewController {
    
    private var lines: [TrainLine] = []
    
    func display(lines: [TrainLine]) {
        self.lines = lines
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lines.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let status = lines[indexPath.row]
        let cell = tableView.dequeueReusableCell(ofType: StatusCell.self)
        cell.configure(for: status)
        return cell
    }
}
