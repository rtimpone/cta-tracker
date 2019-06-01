//
//  ThemeColors.swift
//  CTATracker
//
//  Created by Rob Timpone on 5/27/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import UIKit

protocol ThemeColors {
    
    static var backgroundColor: UIColor { get }
    static var cellBackgroundColor: UIColor { get }
    static var cellTitleLabelColor: UIColor { get }
    static var cellDetailLabelColor: UIColor { get }
    static var cellSeparatorColor: UIColor { get }
    static var navBarBackgroundColor: UIColor { get }
    static var navBarButtonColor: UIColor { get }
    static var navBarTitleColor: UIColor { get }
    static var routeFilterBackgroundColor: UIColor { get }
    static var routeFilterSelectedBorderColor: UIColor { get }
    static var routeFilterUnselectedBorderColor: UIColor { get }
    static var searchBarBackgroundColor: UIColor { get }
    static var searchBarBarColor: UIColor { get }
    static var searchBarTextColor: UIColor { get }
    static var sectionHeaderBackgroundColor: UIColor { get }
    static var sectionHeaderButtonColor: UIColor { get }
    static var sectionHeaderTextColor: UIColor { get }
    static var tableBackgroundColor: UIColor { get }
    static var tableSectionIndexColor: UIColor { get }
}

extension ThemeColors {
    
    static func backgroundTheme() -> BackgroundTheme {
        return BackgroundTheme(backgroundColor: backgroundColor)
    }
    
    static func cellTheme() -> CellTheme {
        return CellTheme(backgroundColor: cellBackgroundColor,
                         titleLabelColor: cellTitleLabelColor,
                         detailLabelColor: cellDetailLabelColor,
                         separatorColor: cellSeparatorColor)
    }
    
    static func navBarTheme(style: NavBarTheme.Style) -> NavBarTheme {
        return NavBarTheme(buttonColor: navBarButtonColor,
                           style: style,
                           titleColor: navBarTitleColor)
    }
    
    static func routeFilterTheme() -> RouteFilterTheme {
        return RouteFilterTheme(backgroundColor: routeFilterBackgroundColor,
                                selectedBorderColor: routeFilterSelectedBorderColor,
                                unselectedBorderColor: routeFilterUnselectedBorderColor)
    }
    
    static func searchBarTheme() -> SearchBarTheme {
        return SearchBarTheme(backgroundColor: searchBarBackgroundColor,
                              barColor: searchBarBarColor,
                              textColor: searchBarTextColor)
    }
    
    static func sectionHeaderTheme() -> SectionHeaderTheme {
        return SectionHeaderTheme(backgroundColor: sectionHeaderBackgroundColor,
                                  buttonColor: sectionHeaderButtonColor,
                                  textColor: sectionHeaderTextColor)
    }
    
    static func tableTheme() -> TableTheme {
        return TableTheme(sectionIndexColor: tableSectionIndexColor)
    }
}

struct LightThemeColors: ThemeColors {
    
    static let customLightBlue = #colorLiteral(red: 0.935859859, green: 0.9516758323, blue: 0.9594567418, alpha: 1)
    static let customLightGray = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
    static let customDarkGray = #colorLiteral(red: 0.4980392157, green: 0.4980392157, blue: 0.4980392157, alpha: 1)
    static let customVeryDarkGray = #colorLiteral(red: 0.1450980392, green: 0.1450980392, blue: 0.1450980392, alpha: 1)
    
    static let backgroundColor: UIColor = customLightBlue
    static let cellBackgroundColor: UIColor = .white
    static let cellTitleLabelColor: UIColor = .black
    static let cellDetailLabelColor: UIColor = .black
    static let cellSeparatorColor: UIColor = customLightGray
    static let navBarBackgroundColor: UIColor = .white
    static let navBarButtonColor: UIColor = .darkGray
    static let navBarTitleColor: UIColor = .black
    static let routeFilterBackgroundColor: UIColor = .white
    static let routeFilterSelectedBorderColor: UIColor = .blue
    static let routeFilterUnselectedBorderColor: UIColor = .white
    static let searchBarBackgroundColor: UIColor = .red
    static let searchBarBarColor: UIColor = .yellow
    static let searchBarTextColor: UIColor = .green
    static let sectionHeaderBackgroundColor: UIColor = customLightGray
    static let sectionHeaderButtonColor: UIColor = customDarkGray
    static let sectionHeaderTextColor: UIColor = customVeryDarkGray
    static let tableBackgroundColor: UIColor = .white
    static let tableSectionIndexColor: UIColor = customDarkGray
}

struct DarkThemeColors: ThemeColors {
    
    static let almostBlack = #colorLiteral(red: 0.08679527789, green: 0.08720482141, blue: 0.08817806095, alpha: 1)
    
    static let backgroundColor: UIColor = .black
    static let cellBackgroundColor: UIColor = .black
    static let cellTitleLabelColor: UIColor = .white
    static let cellDetailLabelColor: UIColor = .white
    static let cellSeparatorColor: UIColor = almostBlack
    static let navBarBackgroundColor: UIColor = almostBlack
    static let navBarButtonColor: UIColor = .orange
    static let navBarTitleColor: UIColor = .white
    static let routeFilterBackgroundColor: UIColor = .black
    static let routeFilterSelectedBorderColor: UIColor = .white
    static let routeFilterUnselectedBorderColor: UIColor = .black
    static let searchBarBackgroundColor: UIColor = .green
    static let searchBarBarColor: UIColor = .red
    static let searchBarTextColor: UIColor = .yellow
    static let sectionHeaderBackgroundColor: UIColor = almostBlack
    static let sectionHeaderButtonColor: UIColor = .lightGray
    static let sectionHeaderTextColor: UIColor = .lightGray
    static let tableBackgroundColor: UIColor = .black
    static let tableSectionIndexColor: UIColor = .orange
}
