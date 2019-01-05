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
    
    let linesToShow = ["Red Line", "Brown Line", "Purple Line"]
    
    weak var tableViewController: TableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //request location permission here
        
        UTCOffsets.lookupOffsets {
            //trigger API refreshes now
            
            CtaClient().getTrainLines() { result in
                switch result {
                case .success(let lines):
                    let filteredLines = lines.filter { self.linesToShow.contains($0.title) }
                    self.tableViewController.display(lines: filteredLines)
                case .failure(let error):
//                    self.viewHandler.showErrorState()
                    print(error)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? TableViewController {
            tableViewController = vc
        }
    }
}
