//
//  RouteDetailsViewController.swift
//  CTATracker
//
//  Created by Rob Timpone on 1/6/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import CTAKit
import UIKit

class RouteDetailsViewController: UIViewController {
    
    var line: TrainLine!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = line.title
    }
}
