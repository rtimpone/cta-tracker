//
//  Theme.swift
//  CTATracker
//
//  Created by Rob Timpone on 5/27/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import UIKit

struct CellTheme {
    let titleLabelColor: UIColor
    let detailLabelColor: UIColor
}

struct NavBarTheme {
    let backgroundColor: UIColor
    let buttonColor: UIColor
    let titleColor: UIColor
}

struct RouteFilterTheme {
    let backgroundColor: UIColor
    let selectedBorderColor: UIColor
    let unselectedBorderColor: UIColor
}

struct SearchBarTheme {
    let backgroundColor: UIColor
    let barColor: UIColor
    let textColor: UIColor
}

struct SectionHeaderTheme {
    let backgroundColor: UIColor
    let buttonColor: UIColor
    let textColor: UIColor
}

struct TableTheme {
    let backgroundColor: UIColor
    let sectionIndexColor: UIColor
}

class Theme {
    
    let identifier: String
    let cellTheme: CellTheme
    let navBarTheme: NavBarTheme
    let routeFilterTheme: RouteFilterTheme
    let searchBarTheme: SearchBarTheme
    let sectionHeaderTheme: SectionHeaderTheme
    let tableTheme: TableTheme
    
    init(identifier: String) {
        
        self.identifier = identifier
        let package = ColorPackage(identifier: identifier)
        
        self.cellTheme = package.cellTheme()
        self.navBarTheme = package.navBarTheme()
        self.routeFilterTheme = package.routeFilterTheme()
        self.searchBarTheme = package.searchBarTheme()
        self.sectionHeaderTheme = package.sectionHeaderTheme()
        self.tableTheme = package.tableTheme()
    }
}

class LightTheme: Theme {
    
    init() {
        super.init(identifier: "Light")
    }
}

class DarkTheme: Theme {
    
    init() {
        super.init(identifier: "Dark")
    }
}
