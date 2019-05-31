//
//  Theme.swift
//  CTATracker
//
//  Created by Rob Timpone on 5/27/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import UIKit

struct BackgroundTheme {
    let backgroundColor: UIColor
}

struct CellTheme {
    let backgroundColor: UIColor
    let titleLabelColor: UIColor
    let detailLabelColor: UIColor
    let separatorColor: UIColor
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
    let style: UIStatusBarStyle
}

struct TableTheme {
    let backgroundColor: UIColor
    let sectionIndexColor: UIColor
}

protocol Themeable {
    func applyTheme(_ theme: Theme)
}

extension Themeable {
    func applyCurrentTheme() {
        let currentTheme = ThemeManager.currentTheme()
        applyTheme(currentTheme)
    }
}

class Theme {

    let name: String
    let backgroundTheme: BackgroundTheme
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
    
    init(name: String, colors: ThemeColors.Type, statusBarTheme: StatusBarTheme) {
        
        self.name = name
        self.statusBarTheme = statusBarTheme
        
        self.backgroundTheme = colors.backgroundTheme()
        self.cellTheme = colors.cellTheme()
        self.navBarTheme = colors.navBarTheme()
        self.routeFilterTheme = colors.routeFilterTheme()
        self.searchBarTheme = colors.searchBarTheme()
        self.sectionHeaderTheme = colors.sectionHeaderTheme()
        self.tableTheme = colors.tableTheme()
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
        let statusBarTheme = StatusBarTheme(style: .default)
        super.init(name: "Light", colors: LightThemeColors.self, statusBarTheme: statusBarTheme)
    }
}

class DarkTheme: Theme {
    
    init() {
        let statusBarTheme = StatusBarTheme(style: .lightContent)
        super.init(name: "Dark", colors: DarkThemeColors.self, statusBarTheme: statusBarTheme)
    }
}
