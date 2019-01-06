//
//  StatusViewController.swift
//  CTATracker
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import CTAKit
import UIKit

class StatusViewController: UIViewController {
    
    let linesToShow = ["Red Line", "Brown Line", "Purple Line"]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var displayView: UIView!
    @IBOutlet weak var errorView: UIView!
    
    var tableHandler: StatusTableHandler!
    var viewHandler: ViewHandler!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableHandler = StatusTableHandler(tableView: tableView)
        viewHandler = ViewHandler(displayView: displayView, errorView: errorView, loadingView: loadingView, loadingIndicator: loadingIndicator)
    }
    
    func refreshTrainLines() {
        
        viewHandler.showLoadingState()
        
        let client = CtaClient()
        client.getTrainLines() { result in
            switch result {
            case .success(let lines):
                self.filterLinesAndDisplayThem(lines)
            case .failure(let error):
                self.viewHandler.showErrorState()
                print(error)
            }
        }
    }
    
    func filterLinesAndDisplayThem(_ lines: [TrainLine]) {
        let filteredLines = lines.filter { linesToShow.contains($0.title) }
        tableHandler.display(lines: filteredLines)
        viewHandler.showDisplayState()
    }
}
