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
    
    enum QueueResult {
        case success
        case error
    }
    
    let stopsToShow: [String] = []
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var displayView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var tableHandler: ArrivalsTableHandler!
    var viewHandler: ViewHandler!
    
    var stopsQueue: [TrainStop] = []
    var arrivals: [StationArrivals] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableHandler = ArrivalsTableHandler(tableView: tableView)
        viewHandler = ViewHandler(displayView: displayView, errorView: errorView, loadingView: loadingView, loadingIndicator: loadingIndicator)
        stopsQueue = TrainStop.allStops
    }
    
    func refreshArrivalTimes() {
        viewHandler.showLoadingState()
        processNextInQueue()
    }
    
    func processNextInQueue() {
        
        guard stopsQueue.count > 0 else {
            filterArrivalsAndDisplayThem()
            return
        }
        
        let nextInQueue = stopsQueue.removeFirst()
        downloadArrivalTimes(forStop: nextInQueue) { result in
            switch result {
            case .success:
                self.processNextInQueue()
            case .error:
                self.viewHandler.showErrorState()
            }
        }
    }
    
    func downloadArrivalTimes(forStop stop: TrainStop, completion: @escaping (QueueResult) -> ()) {
        
        let client = CtaClient()
        client.getArrivals(forStop: stop) { result in
            switch result {
            case .success(let arrivals):
                self.arrivals.append(arrivals)
                completion(.success)
            case .failure(let error):
                print(error)
                completion(.error)
            }
        }
    }
    
    func filterArrivalsAndDisplayThem() {
        
        //filter out only the stops we want
        
        tableHandler.display(arrivals: arrivals)
        viewHandler.showDisplayState()
    }
}
