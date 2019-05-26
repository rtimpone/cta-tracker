//
//  SectionIndexTitlesHandlerTests.swift
//  CTATrackerTests
//
//  Created by Rob Timpone on 5/26/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import XCTest
@testable import CTA

class SectionIndexTitlesFactoryTests: XCTestCase {
    
    func testCanPopulateMissingEntries() {
        let data = ["Bucktown", "Lakeview", "Lincoln Park", "Ravenswood", "River North"]
        let expected = [
            "#": 0,
            "A": 0,
            "B": 0,
            "C": 1,
            "D": 1,
            "E": 1,
            "F": 1,
            "G": 1,
            "H": 1,
            "I": 1,
            "J": 1,
            "K": 1,
            "L": 1,
            "M": 3,
            "N": 3,
            "O": 3,
            "P": 3,
            "Q": 3,
            "R": 3,
            "S": 3,
            "T": 3,
            "U": 3,
            "V": 3,
            "W": 3,
            "X": 3,
            "Y": 3,
            "Z": 3
        ]
        let result = SectionIndexTitlesFactory.sectionIndexTitlesToSectionNumbersDictionary(forSortedStrings: data)
        XCTAssertEqual(result, expected, "Expected the result to exactly match the dictionary above, with values listed for missing entries")
    }
    
    func testCanHandleNumbers() {
        let data = ["42nd Street", "Hamilton", "The Book of Mormon"]
        let result = SectionIndexTitlesFactory.sectionIndexTitlesToSectionNumbersDictionary(forSortedStrings: data)
        XCTAssertEqual(result["#"], 0, "Expected the '#' title to have a section number of zero because '42nd Street' starts with a number")
    }

    func testIsCaseInsensitive() {
        let data = ["Lakeview", "ravenswood", "River North", "South Loop"]
        let result = SectionIndexTitlesFactory.sectionIndexTitlesToSectionNumbersDictionary(forSortedStrings: data)
        XCTAssertEqual(result["R"], 1, "Expected section 1 ('ravenswood') to be listed as the section number for 'R'")
    }
}
