//
//  HapticsManager.swift
//  CTATracker
//
//  Created by Rob Timpone on 5/25/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import UIKit

struct HapticsManager {
    
    let feedback = UISelectionFeedbackGenerator()
    
    func fireSelectionHaptic() {
        feedback.prepare()
        DispatchQueue.main.async {
            self.feedback.selectionChanged()
        }
    }
}
