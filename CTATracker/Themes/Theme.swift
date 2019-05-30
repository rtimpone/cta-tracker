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

struct StatusBarTheme {
    enum StatusBarColor {
        case light
        case dark
    }
    let statusBarColor: StatusBarColor
}

struct TableTheme {
    let backgroundColor: UIColor
    let sectionIndexColor: UIColor
}

protocol Themeable {
    func applyTheme(_ theme: Theme)
}

class Theme {

    let name: String
    let cellTheme: CellTheme
    let navBarTheme: NavBarTheme
    let routeFilterTheme: RouteFilterTheme
    let searchBarTheme: SearchBarTheme
    let sectionHeaderTheme: SectionHeaderTheme
    let statusBarTheme: StatusBarTheme
    let tableTheme: TableTheme
    
    static let allThemes = [
        LightTheme(),
        DarkTheme()
    ]
    
    init(name: String, statusBarTheme: StatusBarTheme) {
        
        self.name = name
        let package = ColorPackage(identifier: name)

        self.statusBarTheme = statusBarTheme
        
        self.cellTheme = package.cellTheme()
        self.navBarTheme = package.navBarTheme()
        self.routeFilterTheme = package.routeFilterTheme()
        self.searchBarTheme = package.searchBarTheme()
        self.sectionHeaderTheme = package.sectionHeaderTheme()
        self.tableTheme = package.tableTheme()
    }
    
    static func themeWithName(_ name: String) -> Theme? {
        return allThemes.first(where: { $0.name == name })
    }
}

extension Theme: Equatable {
    
    static func ==(lhs: Theme, rhs: Theme) -> Bool {
        return lhs.name == rhs.name
    }
}

class LightTheme: Theme {
    
    init() {
        let statusBarTheme = StatusBarTheme(statusBarColor: .light)
        super.init(name: "Light", statusBarTheme: statusBarTheme)
    }
}

class DarkTheme: Theme {
    
    init() {
        let statusBarTheme = StatusBarTheme(statusBarColor: .dark)
        super.init(name: "Dark", statusBarTheme: statusBarTheme)
    }
}
