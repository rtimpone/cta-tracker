//
//  NibBased.swift
//  CTATracker
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import UIKit

protocol NibBased {
    static var nibName: String { get }
}

extension NibBased {
    
    static var nibName: String {
        return String(describing: self)
    }
}

extension UITableView {
    
    private struct AssociatedKeys {
        static var registeredNibBasedCells = "kRegisteredNibBasedCells"
    }
    
    //this allows us to add a stored property of type Set<String> to all UITableViews
    //(adding properties via an extension is not supported by Swift)
    var registeredNibBasedCells: Set<String>? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.registeredNibBasedCells) as? Set<String>
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.registeredNibBasedCells, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(ofType type: T.Type) -> T where T: NibBased {
        
        if registeredNibBasedCells == nil {
            registeredNibBasedCells = Set<String>()
        }
        
        guard let registeredCells = registeredNibBasedCells else {
            fatalError("Unable to access the set of registered nib-based cells")
        }
        
        let className = type.nibName
        if !registeredCells.contains(className) {
            let bundle = Bundle(for: type)
            let nib = UINib(nibName: className, bundle: bundle)
            register(nib, forCellReuseIdentifier: className)
            registeredNibBasedCells?.insert(className)
        }
        
        guard let dequeuedCell = dequeueReusableCell(withIdentifier: className) else {
            fatalError("Unable to dequeue reusable cell with identifier '\(className)'")
        }
        
        guard let castedCell = dequeuedCell as? T else {
            fatalError("Unable to cast dequeued cell to type '\(className)'")
        }
        
        return castedCell
    }
}
