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
    }
    
    func refreshArrivalTimes() {
        
        viewHandler.showLoadingState()
        
        let client = CTAClient()
        client.getArrivals() { result in
            switch result {
            case .success(let arrivals):
                self.filterArrivalsAndDisplayThem([arrivals])
            case .failure(let error):
                self.viewHandler.showErrorState()
                print(error)
            }
        }
    }
    
    func filterArrivalsAndDisplayThem(_ arrivals: [StationArrivals]) {
        
        //filter out only the stops we want
        
        tableHandler.display(arrivals: arrivals)
        viewHandler.showDisplayState()
    }
}
