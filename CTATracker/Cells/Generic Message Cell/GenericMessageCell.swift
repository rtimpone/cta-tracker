//
//  ErrorCell.swift
//  CTATracker
//
//  Created by Rob Timpone on 1/5/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import UIKit

class GenericMessageCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    func configure(withText text: String) {
        label.text = text
    }
}
