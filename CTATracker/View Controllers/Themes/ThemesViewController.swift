//
//  ThemesViewController.swift
//  CTATracker
//
//  Created by Rob Timpone on 5/27/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import UIKit

class ThemesViewController: UIViewController {
    
}

class ThemesTableViewController: UITableViewController {
    
    
}

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
    
    let cellTheme: CellTheme
    let navBarTheme: NavBarTheme
    let routeFilterTheme: RouteFilterTheme
    let searchBarTheme: SearchBarTheme
    let sectionHeaderTheme: SectionHeaderTheme
    let tableTheme: TableTheme
    
    init(identifier: String) {
        
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
        super.init(identifier: "light")
    }
}

class DarkTheme: Theme {
    
    init() {
        super.init(identifier: "dark")
    }
}

struct ColorPackage {
    
    enum ColorIdentifiers: String, CaseIterable {
        case cellTitleLabelColor
        case cellDetailLabelColor
        case navBarBackgroundColor
        case navBarButtonColor
        case navBarTitleColor
        case routeFilterBackgroundColor
        case routeFilterSelectedBorderColor
        case routeFilterUnselectedBorderColor
        case searchBarBackgroundColor
        case searchBarBarColor
        case searchBarTextColor
        case sectionHeaderBackgroundColor
        case sectionHeaderButtonColor
        case sectionHeaderTextColor
        case tableBackgroundColor
        case tableSectionIndexColor
    }
    
    let identifiersToColors: [ColorIdentifiers: UIColor]
    
    init(identifier assetCatalogIdentifier: String) {
        var identifiersToColors: [ColorIdentifiers: UIColor] = [:]
        for identifier in ColorIdentifiers.allCases {
            let colorName = assetCatalogIdentifier + "-" + identifier.rawValue
            let color = UIColor(named: colorName)
            identifiersToColors[identifier] = color
        }
        self.identifiersToColors = identifiersToColors
    }
    
    func cellTheme() -> CellTheme {
        return CellTheme(titleLabelColor: color(for: .cellTitleLabelColor),
                         detailLabelColor: color(for: .cellDetailLabelColor))
    }
    
    func navBarTheme() -> NavBarTheme {
        return NavBarTheme(backgroundColor: color(for: .navBarBackgroundColor),
                           buttonColor: color(for: .navBarButtonColor),
                           titleColor: color(for: .navBarTitleColor))
    }
    
    func routeFilterTheme() -> RouteFilterTheme {
        return RouteFilterTheme(backgroundColor: color(for: .routeFilterBackgroundColor),
                                selectedBorderColor: color(for: .routeFilterSelectedBorderColor),
                                unselectedBorderColor: color(for: .routeFilterUnselectedBorderColor))
    }
    
    func searchBarTheme() -> SearchBarTheme {
        return SearchBarTheme(backgroundColor: color(for: .searchBarBackgroundColor),
                              barColor: color(for: .searchBarBarColor),
                              textColor: color(for: .searchBarTextColor))
    }
    
    func sectionHeaderTheme() -> SectionHeaderTheme {
        return SectionHeaderTheme(backgroundColor: color(for: .sectionHeaderBackgroundColor),
                                  buttonColor: color(for: .sectionHeaderButtonColor),
                                  textColor: color(for: .sectionHeaderTextColor))
    }
    
    func tableTheme() -> TableTheme {
        return TableTheme(backgroundColor: color(for: .tableBackgroundColor),
                          sectionIndexColor: color(for: .tableSectionIndexColor))
    }
}

private extension ColorPackage {
    
    func color(for identifier: ColorIdentifiers) -> UIColor {
        return identifiersToColors[identifier] ?? .white
    }
}
