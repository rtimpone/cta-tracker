//
//  RootViewController.swift
//  CTATracker
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import CTAKit
import UIKit

class RootViewController: UIViewController {
    
    var statusController: StatusViewController!
    var arrivalsController: ArrivalsViewController!
    
    @IBOutlet weak var statusViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //request location permission here
        
        UTCOffsets.lookupOffsets {
            self.statusController.refreshTrainLines()
            self.arrivalsController.refreshArrivalTimes()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: self)
        if let vc = segue.destination as? StatusViewController {
            statusController = vc
            vc.delegate = self
        }
        else if let vc = segue.destination as? ArrivalsViewController {
            arrivalsController = vc
        }
    }
}

extension RootViewController: StatusViewControllerDelegate {
    
    func tableContentHeightDidUpdate(_ newHeight: CGFloat) {
        let minHeightForTableView = CGFloat(138)
        if newHeight > minHeightForTableView {
            statusViewHeightConstraint.constant = newHeight
            view.layoutIfNeeded()
        }
    }
}
