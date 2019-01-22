//
//  ArrivalDescriptionGeneratorTests.swift
//  CTATrackerTests
//
//  Created by Rob Timpone on 12/23/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import XCTest
import CTAKit
@testable import CTA

class ArrivalDescriptionGeneratorTests: XCTestCase {
    
    func testDescriptionForApproachingTrain() {
        let description = ArrivalDescriptionGenerator.string(for: .approaching)
        XCTAssertEqual(description, "Approaching", "Incorrect description for a train that is approaching")
    }
    
    func testDescriptionForDelayedTrain() {
        let description = ArrivalDescriptionGenerator.string(for: .delayed)
        XCTAssertEqual(description, "Delayed", "Incorrect description for a train that is delayed")
    }
    
    func testDescriptionForUnavailableStatus() {
        let description = ArrivalDescriptionGenerator.string(for: .unavailable)
        XCTAssertEqual(description, "Unavailable", "Incorrect description for a train with an unavailable eta")
    }
    
    func testDescriptionForTrainDueInNegativeSeconds() {
        let seconds = -35
        let expectedString = "Overdue"
        assertStringForEnRouteTrainArriving(inSeconds: seconds, matches: expectedString)
        assertStringForScheduledTrainArriving(inSeconds: seconds, matches: expectedString)
    }
    
    func testDescriptionForTrainDueInZeroSeconds() {
        let seconds = 0
        let expectedString = "Due"
        assertStringForEnRouteTrainArriving(inSeconds: seconds, matches: expectedString)
        assertStringForScheduledTrainArriving(inSeconds: seconds, matches: expectedString)
    }
    
    func testDescriptionForTrainDueInOneSeconds() {
        let seconds = 1
        let expectedString = "Due"
        assertStringForEnRouteTrainArriving(inSeconds: seconds, matches: expectedString)
        assertStringForScheduledTrainArriving(inSeconds: seconds, matches: expectedString)
    }
    
    func testDescriptionForTrainDueInFiftyNineSeconds() {
        let seconds = 59
        let expectedString = "Due"
        assertStringForEnRouteTrainArriving(inSeconds: seconds, matches: expectedString)
        assertStringForScheduledTrainArriving(inSeconds: seconds, matches: expectedString)
    }
    
    func testDescriptionForTrainDueInSixtySeconds() {
        let seconds = 60
        let expectedString = "1 min"
        assertStringForEnRouteTrainArriving(inSeconds: seconds, matches: expectedString)
        assertStringForScheduledTrainArriving(inSeconds: seconds, matches: expectedString)
    }
    
    func testDescriptionForTrainDueInSixtyOneSeconds() {
        let seconds = 61
        let expectedString = "2 min"
        assertStringForEnRouteTrainArriving(inSeconds: seconds, matches: expectedString)
        assertStringForScheduledTrainArriving(inSeconds: seconds, matches: expectedString)
    }
    
    func testDescriptionForTrainDueInEightyNineSeconds() {
        let seconds = 89
        let expectedString = "2 min"
        assertStringForEnRouteTrainArriving(inSeconds: seconds, matches: expectedString)
        assertStringForScheduledTrainArriving(inSeconds: seconds, matches: expectedString)
    }
    
    func testDescriptionForTrainDueInNinetySeconds() {
        let seconds = 90
        let expectedString = "2 min"
        assertStringForEnRouteTrainArriving(inSeconds: seconds, matches: expectedString)
        assertStringForScheduledTrainArriving(inSeconds: seconds, matches: expectedString)
    }
    
    func testDescriptionForTrainDueInNinetyOneSeconds() {
        let seconds = 91
        let expectedString = "2 min"
        assertStringForEnRouteTrainArriving(inSeconds: seconds, matches: expectedString)
        assertStringForScheduledTrainArriving(inSeconds: seconds, matches: expectedString)
    }
    
    func testDescriptionForTrainDueInTwoMinutes() {
        let seconds = 120
        let expectedString = "2 min"
        assertStringForEnRouteTrainArriving(inSeconds: seconds, matches: expectedString)
        assertStringForScheduledTrainArriving(inSeconds: seconds, matches: expectedString)
    }
    
    func testDescriptionForTrainDueInThreeAndAHalfMinutes() {
        let seconds = 210
        let expectedString = "4 min"
        assertStringForEnRouteTrainArriving(inSeconds: seconds, matches: expectedString)
        assertStringForScheduledTrainArriving(inSeconds: seconds, matches: expectedString)
    }
    
    func testDescriptionForTrainDueInTwentyMinutes() {
        let seconds = 20 * 60
        let expectedString = "20 min"
        assertStringForEnRouteTrainArriving(inSeconds: seconds, matches: expectedString)
        assertStringForScheduledTrainArriving(inSeconds: seconds, matches: expectedString)
    }
    
    func testDescriptionForTrainDueInThirtyMinutes() {
        let seconds = 30 * 60
        let expectedString = "30 min"
        assertStringForEnRouteTrainArriving(inSeconds: seconds, matches: expectedString)
        assertStringForScheduledTrainArriving(inSeconds: seconds, matches: expectedString)
    }
    
    func testDescriptionForTrainDueInThirtyOneMinutes() {
        let seconds = 31 * 60
        let expectedString = "31 min"
        assertStringForEnRouteTrainArriving(inSeconds: seconds, matches: expectedString)
        assertStringForScheduledTrainArriving(inSeconds: seconds, matches: expectedString)
    }
    
    func testDescriptionForTrainDueInSixtyMinutes() {
        let seconds = 60 * 60
        let expectedString = "1 hour"
        assertStringForEnRouteTrainArriving(inSeconds: seconds, matches: expectedString)
        assertStringForScheduledTrainArriving(inSeconds: seconds, matches: expectedString)
    }
    
    func testDescriptionForTrainDueInSixtyOneMinutes() {
        let seconds = 61 * 60
        let expectedString = "Over an hour"
        assertStringForEnRouteTrainArriving(inSeconds: seconds, matches: expectedString)
        assertStringForScheduledTrainArriving(inSeconds: seconds, matches: expectedString)
    }
}

private extension ArrivalDescriptionGeneratorTests {
    
    func assertStringForEnRouteTrainArriving(inSeconds seconds: Int, matches expectedString: String, file: StaticString = #file, line: UInt = #line) {
        
        let status = ArrivalStatus.enRoute(seconds: seconds)
        let description = ArrivalDescriptionGenerator.string(for: status)
        XCTAssertEqual(description, expectedString, "Incorrect description for en route train", file: file, line: line)
    }
    
    func assertStringForScheduledTrainArriving(inSeconds seconds: Int, matches expectedString: String, file: StaticString = #file, line: UInt = #line) {
        let status = ArrivalStatus.scheduled(seconds: seconds)
        let description = ArrivalDescriptionGenerator.string(for: status)
        XCTAssertEqual(description, expectedString, "Incorrect description for scheduled train", file: file, line: line)
    }
}
