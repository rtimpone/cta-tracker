//
//  ArrivalsViewController.swift
//  CTATracker
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import CTAKit
import UIKit

class ArrivalsViewController: UIViewController {
    
    let stopsToShow: [String] = []
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var displayView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var tableHandler: ArrivalsTableHandler!
    var viewHandler: ViewHandler!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableHandler = ArrivalsTableHandler(tableView: tableView)
        viewHandler = ViewHandler(displayView: displayView, errorView: errorView, loadingView: loadingView, loadingIndicator: loadingIndicator)
        refreshArrivalTimes()
    }
    
    func refreshArrivalTimes() {
        
        viewHandler.showLoadingState()
        
        let client = CTAClient()
        client.getArrivals() { result in
            switch result {
            case .success(let arrivals):
                for arrival in arrivals {
                    print(arrival)
                }
            case .failure(let error):
                print(error)
            }
        }
        
        //call API
        //if success
        filterArrivalsAndDisplayThem()
        //else let error
        //self.viewHandler.showErrorState()
        //print(error)
    }
    
    func filterArrivalsAndDisplayThem() {
        
        //filter out only the stops we want
        
        let arrivals = [String]()
        tableHandler.display(arrivalTimes: arrivals)
        viewHandler.showDisplayState()
    }
}

class ArrivalsTableHandler: NSObject {
    
    weak var tableView: UITableView!
    private var stops: [String] = []
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.dataSource = self
    }
    
    func display(arrivalTimes: [String]) {
        self.stops = arrivalTimes
        tableView.reloadData()
    }
}

extension ArrivalsTableHandler: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
