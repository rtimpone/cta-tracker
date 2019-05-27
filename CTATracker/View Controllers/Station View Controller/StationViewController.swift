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
    
    var stop: Stop!
    var arrivals: StopArrivals?
    weak var tableViewController: StationTableViewController!
    let requestHandler = StationRequestHandler()
    let timerManager = TimerManager()
    var secondsElapsed = 0
    
    static func instance(for stop: Stop, withArrivals arrivals: StopArrivals? = nil) -> StationViewController {
        let vc = StationViewController.instantiateFromStoryboard()
        vc.stop = stop
        vc.arrivals = arrivals
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let etas = arrivals?.etas ?? []
        tableViewController.setEtas(etas, for: stop)
        tableViewController.reloadEtas()
        timerManager.delegate = self
        requestUpdatedEtas()
        
        //need to set this explicity so nav bar will show when pushed from single stop search vc
        navigationController?.setNavigationBarHidden(false, animated: false)
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
        
        tableViewController.reloadEtas()
        
        secondsElapsed += 1
        if secondsElapsed % 10 == 0 {
            requestUpdatedEtas()
        }
    }
    
    func requestUpdatedEtas() {
        requestHandler.requestUpdatedArrivalTimes(forStop: stop) { result in
            if let arrivals = result.value {
                self.arrivals = arrivals
                self.tableViewController.setEtas(arrivals.etas, for: arrivals.stop)
            }
        }
    }
}
