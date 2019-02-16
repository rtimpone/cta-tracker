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
    
    static func instance(withArrivals arrivals: StopArrivals) -> StationViewController {
        let vc = StationViewController.instantiateFromStoryboard()
        vc.arrivals = arrivals
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewController.displayEtas(arrivals.etas)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: self)
        if let vc = segue.destination as? StationTableViewController {
            tableViewController = vc
        }
    }
}
