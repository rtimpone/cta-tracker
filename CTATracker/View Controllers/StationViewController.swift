//
//  StationViewController.swift
//  CTATracker
//
//  Created by Rob Timpone on 2/16/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CTAKit
import StoryboardInstantiable
import UIKit

class StationViewController: UIViewController {
    
    var arrivals: StopArrivals!
    weak var tableViewController: StationTableViewController!
    let requestHandler = StationRequestHandler()
    let timerManager = TimerManager()
    var secondsElapsed = 0
    
    static func instance(withArrivals arrivals: StopArrivals) -> StationViewController {
        let vc = StationViewController.instantiateFromStoryboard()
        vc.arrivals = arrivals
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewController.setEtas(arrivals.etas, for: arrivals.stop)
        tableViewController.reloadEtas()
        timerManager.delegate = self
        requestUpdatedEtas()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timerManager.startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timerManager.stopTimer()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: self)
        if let vc = segue.destination as? StationTableViewController {
            tableViewController = vc
        }
    }
}

extension StationViewController: TimerManagerDelegate {
    
    func timerDidFire() {
        
        print("reloading etas")
        tableViewController.reloadEtas()
        
        secondsElapsed += 1
        if secondsElapsed % 10 == 0 {
            print("requesting updated etas")
            requestUpdatedEtas()
        }
    }
    
    func requestUpdatedEtas() {
        requestHandler.requestUpdatedArrivalTimes(forStop: arrivals.stop) { result in
            if let arrivals = result.value {
                self.arrivals = arrivals
                print("setting new etas")
                self.tableViewController.setEtas(arrivals.etas, for: arrivals.stop)
            }
        }
    }
}
