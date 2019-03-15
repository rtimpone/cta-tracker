//
//  UIColor+Extensions.swift
//  CTAKit
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import Foundation

extension UIColor {
    
    public convenience init(hex: String) {
        
        let trimmedString = hex.replacingOccurrences(of: "#", with: "")
        
        var uint32Value: UInt32 = 0
        Scanner(string: trimmedString).scanHexInt32(&uint32Value)
        
        let intValue = Int(uint32Value)
        self.init(hex: intValue)
    }
    
    convenience init(hex: Int) {
        
        let r = CGFloat((hex >> 16) & 0xff) / 255
        let g = CGFloat((hex >> 08) & 0xff) / 255
        let b = CGFloat((hex >> 00) & 0xff) / 255
        
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
}
