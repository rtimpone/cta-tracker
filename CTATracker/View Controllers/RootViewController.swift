//
//  RootViewController.swift
//  CTATracker
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    @IBOutlet weak var statusViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //request location permission here 
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: self)
        if let vc = segue.destination as? StatusViewController {
            vc.delegate = self
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
