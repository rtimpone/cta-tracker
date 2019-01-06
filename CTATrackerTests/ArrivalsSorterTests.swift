//
//  ArrivalsSorterTests.swift
//  CTAKitTests
//
//  Created by Rob Timpone on 1/5/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import XCTest
@testable import CTAKit
@testable import CTATracker

class ArrivalsSorterTests: XCTestCase {

    let sheridanAndLunt = Coordinate(latitude: 42.008938, longitude: 87.661996)
    let westernAndLawrence = Coordinate(latitude: 41.968438, longitude: -87.688882)
    let stateAndJackson = Coordinate(latitude: 41.877623, longitude: -87.627740)
    
    let arrivals: [StationArrivals] = [
        mockArrival(forStopNamed: "Adams/Wabash", latitude: 41.879507, longitude: -87.626037),
        mockArrival(forStopNamed: "Damen", latitude: 41.966286, longitude: -87.678639),
        mockArrival(forStopNamed: "Belmont", latitude: 41.939751, longitude: -87.65338),
        mockArrival(forStopNamed: "Belmont", latitude: 41.939751, longitude: -87.65338),
        mockArrival(forStopNamed: "Belmont", latitude: 41.939751, longitude: -87.65338),
        mockArrival(forStopNamed: "Belmont", latitude: 41.939751, longitude: -87.65338),
        mockArrival(forStopNamed: "Belmont", latitude: 41.939751, longitude: -87.65338),
        mockArrival(forStopNamed: "Morse", latitude: 42.008362, longitude: -87.665909),
        mockArrival(forStopNamed: "Monroe", latitude: 41.880745, longitude: -87.627696)
    ]
    
    func testSortEmptyArray() {
        let emptyStopsArray: [StationArrivals] = []
        let sortedArrivals = ArrivalsSorter.sortArrivals(emptyStopsArray, byDistanceTo: sheridanAndLunt)
        XCTAssertEqual(sortedArrivals.count, 0, "Expected a sorted empty array to be an empty array")
    }
    
    func testSingleItemArray() {
        let damen = arrivals[1]
        let singleArrivalsArray: [StationArrivals] = [damen]
        let sortedArrivals = ArrivalsSorter.sortArrivals(singleArrivalsArray, byDistanceTo: sheridanAndLunt)
        let closestArrival = sortedArrivals.first!
        XCTAssertEqual(closestArrival.stop.name, "Damen", "Expected a sorted single item array to be the same array")
    }
    
    func testNorthernLocation() {
        let sortedArrivals = ArrivalsSorter.sortArrivals(arrivals, byDistanceTo: sheridanAndLunt)
        let closestArrival = sortedArrivals.first!
        XCTAssertEqual(closestArrival.stop.name, "Morse", "Expected Morse to be reported as the stop closest the Sheridan & Lunt")
    }
    
    func testSouthernLocation() {
        let sortedArrivals = ArrivalsSorter.sortArrivals(arrivals, byDistanceTo: stateAndJackson)
        let closestArrival = sortedArrivals.first!
        XCTAssertEqual(closestArrival.stop.name, "Adams/Wabash", "Expected Adams & Wabash to be reported as the stop closest the State & Jackson")
    }
    
    func testWesternLocation() {
        let sortedArrivals = ArrivalsSorter.sortArrivals(arrivals, byDistanceTo: westernAndLawrence)
        let closestArrival = sortedArrivals.first!
        XCTAssertEqual(closestArrival.stop.name, "Damen", "Expected Damen to be reported as the stop closest the Western & Lawrence")
    }
}

private extension ArrivalsSorterTests {
    
    static func mockArrival(forStopNamed name: String, latitude: Double, longitude: Double) -> StationArrivals {
        
        let mockJSON = """
        {
            "staId": "40680",
            "staNm": "Adams/Wabash",
            "rt": "G",
            "destNm": "Harlem/Lake",
            "arrT": "2019-01-05T21:03:59",
            "isApp": "1",
            "isSch": "0",
            "isDly": "0",
            "isFlt": "0",
        }
        """
        
        let decoder = JSONDecoder()
        let arrivalResponse = try! decoder.decode(ArrivalETAResponse.self, from: mockJSON.data(using: .utf8)!)
        let stop = TrainStop(id: 0, name: name, type: .platform, latitude: latitude, longitude: longitude)
        return StationArrivals(from: [arrivalResponse], for: stop)!
    }
}
