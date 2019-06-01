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
    
    enum Style {
        case translucentLight
        case translucentDark
        case opaqueColored(UIColor)
    }

    let buttonColor: UIColor
    let backdropColor: UIColor
    let style: Style
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
    
    init(name: String, colors: ThemeColors.Type, navBarStyle: NavBarTheme.Style, statusBarStyle: UIStatusBarStyle) {
        
        self.name = name
        
        self.backgroundTheme = colors.backgroundTheme()
        self.cellTheme = colors.cellTheme()
        self.navBarTheme = colors.navBarTheme(style: navBarStyle)
        self.routeFilterTheme = colors.routeFilterTheme()
        self.searchBarTheme = colors.searchBarTheme()
        self.sectionHeaderTheme = colors.sectionHeaderTheme()
        self.statusBarTheme = StatusBarTheme(style: statusBarStyle)
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
        super.init(name: "Light", colors: LightThemeColors.self, navBarStyle: .translucentLight, statusBarStyle: .default)
    }
}

class DarkTheme: Theme {
    
    init() {
        super.init(name: "Dark", colors: DarkThemeColors.self, navBarStyle: .translucentDark, statusBarStyle: .lightContent)
    }
}
