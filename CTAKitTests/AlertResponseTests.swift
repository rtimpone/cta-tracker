//
//  AlertResponseTests.swift
//  CTAKitTests
//
//  Created by Rob Timpone on 1/21/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import XCTest
@testable import CTAKit

class AlertResponseTests: XCTestCase {

    var decoder: JSONDecoder!
    
    override func setUp() {
        super.setUp()
        decoder = JSONDecoder()
    }
    
    func testServicesIsADictionary() {
        let json = MockJson.alerts.withSingleServiceImpacted
        assertNumberOfImpactedServices(from: json, equals: 1)
    }
    
    func testServicesIsAnArray() {
        let json = MockJson.alerts.withMultipleServicesImpacted
        assertNumberOfImpactedServices(from: json, equals: 3)
    }
}

private extension AlertResponseTests {
    
    func assertNumberOfImpactedServices(from json: String, equals expectedNumberOfServices: Int, file: StaticString = #file, line: UInt = #line) {
        
        let data = json.data(using: .utf8)!
        
        var optionalContainer: AlertsContainerResponse?
        do {
            optionalContainer = try decoder.decode(AlertsContainerResponse.self, from: data)
        }
        catch {
            XCTFail("Encountered an error attempting to decode the json: \(error)")
        }
        
        guard let container = optionalContainer else {
            XCTFail("Unable to decode json data into an alerts response")
            return
        }
        
        guard let alert = container.root.alerts.first else {
            XCTFail("Expected an alert to be present in the response")
            return
        }
        
        let impactedServices = alert.impactedServicesContainer.services
        XCTAssertEqual(impactedServices.count, expectedNumberOfServices, "Incorrect numbrer of impacted services in the response")
    }
}
