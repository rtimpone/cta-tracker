//
//  ColorPackage.swift
//  CTATracker
//
//  Created by Rob Timpone on 5/27/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import UIKit

struct ColorPackage {
    
    enum ColorIdentifiers: String, CaseIterable {
        case backgroundColor
        case cellBackgroundColor
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
        case tableSeparatorColor
    }
    
    let identifiersToColors: [ColorIdentifiers: UIColor]
    
    init(identifier assetCatalogIdentifier: String) {
        var identifiersToColors: [ColorIdentifiers: UIColor] = [:]
        for identifier in ColorIdentifiers.allCases {
            let colorName = assetCatalogIdentifier + "/" + identifier.rawValue
            let color = UIColor(named: colorName)
            identifiersToColors[identifier] = color
        }
        self.identifiersToColors = identifiersToColors
    }
    
    func backgroundTheme() -> BackgroundTheme {
        return BackgroundTheme(backgroundColor: color(for: .backgroundColor))
    }
    
    func cellTheme() -> CellTheme {
        return CellTheme(backgroundColor: color(for: .cellBackgroundColor),
                         titleLabelColor: color(for: .cellTitleLabelColor),
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
                          sectionIndexColor: color(for: .tableSectionIndexColor),
                          separatorColor: color(for: .tableSeparatorColor))
    }
}

private extension ColorPackage {
    
    func color(for identifier: ColorIdentifiers) -> UIColor {
        return identifiersToColors[identifier] ?? .white
    }
}
