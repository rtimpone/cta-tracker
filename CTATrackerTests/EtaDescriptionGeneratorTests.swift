//
//  EtaDescriptionGeneratorTests.swift
//  CTATrackerTests
//
//  Created by Rob Timpone on 2/16/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import XCTest
import CTAKit
@testable import CTA

class EtaDescriptionGeneratorTests: XCTestCase {
    
    func testArrivalInNegativeSeventySeconds() {
        let output = EtaDescriptionGenerator.stringForTrainArrivingInSeconds(-70)
        XCTAssertEqual(output, "Late by 1m 10s")
    }
    
    func testArrivalInNegativeTenSeconds() {
        let output = EtaDescriptionGenerator.stringForTrainArrivingInSeconds(-10)
        XCTAssertEqual(output, "Late by 10s")
    }
    
    func testArrivalInZeroSeconds() {
        let output = EtaDescriptionGenerator.stringForTrainArrivingInSeconds(0)
        XCTAssertEqual(output, "Now")
    }
    
    func testArrivalInThreeSeconds() {
        let output = EtaDescriptionGenerator.stringForTrainArrivingInSeconds(3)
        XCTAssertEqual(output, "3s")
    }
    
    func testArrivalInThirtySeconds() {
        let output = EtaDescriptionGenerator.stringForTrainArrivingInSeconds(30)
        XCTAssertEqual(output, "30s")
    }
    
    func testArrivalInSixtySeconds() {
        let output = EtaDescriptionGenerator.stringForTrainArrivingInSeconds(60)
        XCTAssertEqual(output, "1m 00s")
    }
    
    func testArrivalInSixtyOneSeconds() {
        let output = EtaDescriptionGenerator.stringForTrainArrivingInSeconds(61)
        XCTAssertEqual(output, "1m 01s")
    }
    
    func testArrivalInSeventyOneSeconds() {
        let output = EtaDescriptionGenerator.stringForTrainArrivingInSeconds(71)
        XCTAssertEqual(output, "1m 11s")
    }
    
    func testArrivalInOneHundredAndTwentySeconds() {
        let output = EtaDescriptionGenerator.stringForTrainArrivingInSeconds(120)
        XCTAssertEqual(output, "2m 00s")
    }
    
    func testArrivalInOneHundredAndTwentyOneSeconds() {
        let output = EtaDescriptionGenerator.stringForTrainArrivingInSeconds(121)
        XCTAssertEqual(output, "2m 01s")
    }
    
    func testArrivalInTenMinutes() {
        let output = EtaDescriptionGenerator.stringForTrainArrivingInSeconds(600)
        XCTAssertEqual(output, "10m 00s")
    }
}
