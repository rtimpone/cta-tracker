//
//  DetailViewController.swift
//  StoryboardInstantiableDemo
//
//  Created by Rob Timpone on 2/16/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var displayText: String!
    @IBOutlet weak var displayLabel: UILabel!
    
    static func instantiate(withDisplayText displayText: String) -> DetailViewController {
        let vc = DetailViewController.instantiateFromStoryboard()
        vc.displayText = displayText
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = displayText
    }
}
