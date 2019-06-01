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
    static var cellPlaceholderLabelColor: UIColor { get }
    static var cellHighlightedLabelColor: UIColor { get }
    static var cellSeparatorColor: UIColor { get }
    static var cellDetailIconColor: UIColor { get }
    static var cellSelectionIconColor: UIColor { get }
    static var navBarBackgroundColor: UIColor { get }
    static var navBarBackdropColor: UIColor { get }
    static var navBarButtonColor: UIColor { get }
    static var navBarTitleColor: UIColor { get }
    static var routeFilterBackgroundColor: UIColor { get }
    static var routeFilterSelectedBorderColor: UIColor { get }
    static var routeFilterUnselectedBorderColor: UIColor { get }
    static var searchBarTintColor: UIColor { get }
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
                         placeholderLabelColor: cellPlaceholderLabelColor,
                         highlightedLabelColor: cellHighlightedLabelColor,
                         separatorColor: cellSeparatorColor,
                         detailIconColor: cellDetailIconColor,
                         selectionIconColor: cellSelectionIconColor)
    }
    
    static func navBarTheme(style: NavBarTheme.Style) -> NavBarTheme {
        return NavBarTheme(buttonColor: navBarButtonColor,
                           backdropColor: navBarBackdropColor,
                           style: style,
                           titleColor: navBarTitleColor)
    }
    
    static func routeFilterTheme() -> RouteFilterTheme {
        return RouteFilterTheme(backgroundColor: routeFilterBackgroundColor,
                                selectedBorderColor: routeFilterSelectedBorderColor,
                                unselectedBorderColor: routeFilterUnselectedBorderColor)
    }
    
    static func searchBarTheme() -> SearchBarTheme {
        return SearchBarTheme(tintColor: searchBarTintColor)
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

struct SharedColors {
    static let customDarkGray = #colorLiteral(red: 0.4980392157, green: 0.4980392157, blue: 0.4980392157, alpha: 1)
}

struct LightThemeColors: ThemeColors {
    
    static let customBlue = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
    static let customLightBlue = #colorLiteral(red: 0.935859859, green: 0.9516758323, blue: 0.9594567418, alpha: 1)
    static let customLightGray = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
    static let customVeryDarkGray = #colorLiteral(red: 0.1450980392, green: 0.1450980392, blue: 0.1450980392, alpha: 1)
    
    static let backgroundColor: UIColor = customLightBlue
    static let cellBackgroundColor: UIColor = .white
    static let cellTitleLabelColor: UIColor = .black
    static let cellDetailLabelColor: UIColor = .black
    static let cellPlaceholderLabelColor: UIColor = .lightGray
    static let cellHighlightedLabelColor: UIColor = .blue
    static let cellSeparatorColor: UIColor = customLightGray
    static let cellDetailIconColor: UIColor = SharedColors.customDarkGray
    static let cellSelectionIconColor: UIColor = .black
    static let navBarBackgroundColor: UIColor = .white
    static let navBarBackdropColor: UIColor = .white
    static let navBarButtonColor: UIColor = SharedColors.customDarkGray
    static let navBarTitleColor: UIColor = .black
    static let routeFilterBackgroundColor: UIColor = .white
    static let routeFilterSelectedBorderColor: UIColor = customBlue
    static let routeFilterUnselectedBorderColor: UIColor = customLightGray
    static let searchBarTintColor: UIColor = customBlue
    static let sectionHeaderBackgroundColor: UIColor = customLightGray
    static let sectionHeaderButtonColor: UIColor = SharedColors.customDarkGray
    static let sectionHeaderTextColor: UIColor = customVeryDarkGray
    static let tableBackgroundColor: UIColor = .white
    static let tableSectionIndexColor: UIColor = SharedColors.customDarkGray
}

struct DarkThemeColors: ThemeColors {
    
    static let almostBlack = #colorLiteral(red: 0.08679527789, green: 0.08720482141, blue: 0.08817806095, alpha: 1)
    static let customDarkGray = #colorLiteral(red: 0.4980392157, green: 0.4980392157, blue: 0.4980392157, alpha: 1)
    
    static let backgroundColor: UIColor = .black
    static let cellBackgroundColor: UIColor = .black
    static let cellTitleLabelColor: UIColor = .white
    static let cellDetailLabelColor: UIColor = .white
    static let cellPlaceholderLabelColor: UIColor = .lightGray
    static let cellHighlightedLabelColor: UIColor = .orange
    static let cellSeparatorColor: UIColor = .darkGray
    static let cellDetailIconColor: UIColor = SharedColors.customDarkGray
    static let cellSelectionIconColor: UIColor = .orange
    static let navBarBackgroundColor: UIColor = almostBlack
    static let navBarBackdropColor: UIColor = .black
    static let navBarButtonColor: UIColor = .orange
    static let navBarTitleColor: UIColor = .white
    static let routeFilterBackgroundColor: UIColor = .black
    static let routeFilterSelectedBorderColor: UIColor = .orange
    static let routeFilterUnselectedBorderColor: UIColor = customDarkGray
    static let searchBarTintColor: UIColor = .orange
    static let sectionHeaderBackgroundColor: UIColor = almostBlack
    static let sectionHeaderButtonColor: UIColor = .darkGray
    static let sectionHeaderTextColor: UIColor = .lightGray
    static let tableBackgroundColor: UIColor = .black
    static let tableSectionIndexColor: UIColor = .lightGray
}
