//
//  StationViewController.swift
//  CTATracker
//
//  Created by Rob Timpone on 2/16/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import StoryboardInstantiable
import UIKit

class StationViewController: UIViewController {
    
    static func instance() -> StationViewController {
        return StationViewController.instantiateFromStoryboard()
    }
}
