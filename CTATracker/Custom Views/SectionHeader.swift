//
//  SectionHeader.swift
//  CTATracker
//
//  Created by Rob Timpone on 1/5/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import UIKit

class SectionHeader: UIView, NibBased {
    
    @IBOutlet weak var label: UILabel!
    
    static func fromNib(withText text: String) -> Self {
        let header = self.fromNib()
        header.label.text = text
        return header
    }
}
