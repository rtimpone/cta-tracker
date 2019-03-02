//
//  StoryboardInstantiable.swift
//  AutoRegistering
//
//  Created by Rob Timpone on 2/15/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import UIKit

protocol StoryboardBased {
    
    static var storyboardName: String { get }
}

extension StoryboardBased {
    
    static var storyboardName: String {
        return String(describing: self)
    }
}

public protocol StoryboardInstantiable: class {
    
    static func instantiateFromStoryboard() -> Self
}
