//
//  ViewController.swift
//  StoryboardInstantiableDemo
//
//  Created by Rob Timpone on 2/16/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    @IBAction func buttonAction(_ sender: UIButton) {
        let vc = DetailViewController.instantiate(withDisplayText: textField.text!)
        navigationController?.pushViewController(vc, animated: true)
    }
}
