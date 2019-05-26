//
//  SectionIndexTitlesFactory.swift
//  CTATracker
//
//  Created by Rob Timpone on 5/26/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import Foundation

class SectionIndexTitlesFactory {
    
    static let sectionIndexTitles = ["#", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    static func sectionIndexTitlesToSectionNumbersDictionary(forSortedStrings sortedStrings: [String]) -> [String: Int] {
        let sectionIndexTitlesToSectionNumbers = dictionaryWithSectionNumbersForIndexTitles(for: sortedStrings)
        return titlesToSectionNumbersDictionaryWithMissingEntriesPopulated(from: sectionIndexTitlesToSectionNumbers)
    }
}

private extension SectionIndexTitlesFactory {
    
    static func dictionaryWithSectionNumbersForIndexTitles(for strings: [String]) -> [String: Int] {
        
        var sectionIndexTitlesToSectionNumbers: [String: Int] = [:]
        var charactersEncountered: Set<String> = []
        
        for (index, string) in strings.enumerated() {
            
            let firstCharacter = String(string.prefix(1)).uppercased()
            let isNumber = Int(firstCharacter) != nil
            let indexTitle = isNumber ? "#" : firstCharacter
            let isFirstTimeEncounteringCharacter = !charactersEncountered.contains(indexTitle)
            
            if isFirstTimeEncounteringCharacter {
                sectionIndexTitlesToSectionNumbers[indexTitle] = index
                charactersEncountered.insert(indexTitle)
            }
        }
        
        return sectionIndexTitlesToSectionNumbers
    }
    
    static func titlesToSectionNumbersDictionaryWithMissingEntriesPopulated(from dictionary: [String: Int]) -> [String: Int] {
        
        var dictionaryWithMissingEntriesPopulated = dictionary
        
        for (index, sectionIndexTitle) in sectionIndexTitles.enumerated() {
            if dictionaryWithMissingEntriesPopulated[sectionIndexTitle] == nil {
                if let nextSectionNumber = sectionNumber(in: dictionaryWithMissingEntriesPopulated, afterTitleIndex: index) {
                    dictionaryWithMissingEntriesPopulated[sectionIndexTitle] = nextSectionNumber
                }
                else if let previousSectionNumber = sectionNumber(in: dictionaryWithMissingEntriesPopulated, beforeTitleIndex: index) {
                    dictionaryWithMissingEntriesPopulated[sectionIndexTitle] = previousSectionNumber
                }
            }
        }
        
        return dictionaryWithMissingEntriesPopulated
    }
    
    static func sectionNumber(in dictionary: [String: Int], afterTitleIndex titleIndex: Int) -> Int? {
        for forwardIndex in (titleIndex + 1)..<sectionIndexTitles.count {
            let forwardTitle = sectionIndexTitles[forwardIndex]
            if let sectionNumber = dictionary[forwardTitle] {
                return sectionNumber
            }
        }
        return nil
    }
    
    static func sectionNumber(in dictionary: [String: Int], beforeTitleIndex titleIndex: Int) -> Int? {
        for backwardsIndex in (0..<titleIndex).reversed() {
            let backwardsTitle = sectionIndexTitles[backwardsIndex]
            if let sectionNumber = dictionary[backwardsTitle] {
                return sectionNumber
            }
        }
        return nil
    }
}
