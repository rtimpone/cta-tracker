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
    
    weak var tableViewController: TableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //request location permission here
        
        UTCOffsets.lookupOffsets {
            self.refreshDataFromApi()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? TableViewController {
            vc.delegate = self
            tableViewController = vc
        }
    }
}

extension RootViewController: TableViewDelegate {
    
    func refreshControlWasActivated() {
        refreshDataFromApi()
    }
}

private extension RootViewController {
    
    func refreshDataFromApi() {
        StatusRequestHandler.requestTrainStatus() { result in
            switch result {
            case .success(let lines):
                self.tableViewController.displayTrainLines(lines)
            case .error:
                self.tableViewController.displayTrainLinesError()
            }
        }
    }
}
