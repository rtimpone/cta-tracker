//
//  SectionHeader.swift
//  CTATracker
//
//  Created by Rob Timpone on 1/5/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import UIKit

protocol HomeSectionHeaderDelegate: class {
    func didSelectHeader(inSection section: Int)
}

class HomeSectionHeader: UITableViewHeaderFooterView {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    weak var delegate: HomeSectionHeaderDelegate?
    
    func configure(withText text: String, theme: Theme, inSection section: Int, delegate: HomeSectionHeaderDelegate) {
        
        backgroundColor = theme.sectionHeaderTheme.backgroundColor
        label.textColor = theme.sectionHeaderTheme.textColor
        button.setTitleColor(theme.sectionHeaderTheme.buttonColor, for: .normal)
        
        label.text = text
        setSectionNumber(section)
        self.delegate = delegate
    }
    
    @IBAction func editAction(_ sender: UIButton) {
        let section = sectionNumber()
        delegate?.didSelectHeader(inSection: section)
    }
}

private extension HomeSectionHeader {
    
    func setSectionNumber(_ section: Int) {
        tag = section
    }
    
    func sectionNumber() -> Int {
        return tag
    }
}
