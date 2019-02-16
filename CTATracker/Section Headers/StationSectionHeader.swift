//
//  StationSectionHeader.swift
//  CTATracker
//
//  Created by Rob Timpone on 2/16/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import UIKit

class StationSectionHeader: UITableViewHeaderFooterView {
    
    @IBOutlet weak var label: UILabel!
    
    func configure(withText text: String) {
        label.text = text
    }
}
