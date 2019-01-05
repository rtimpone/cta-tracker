//
//  CTAKitTests.swift
//  CTAKitTests
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import XCTest
@testable import CTAKit

class URLExtensionTests: XCTestCase {

    let urlString = "http://www.example.com"
    
    func testURLWithNoParams() {
        let params: [String: String] = [:]
        let url = URL(string: urlString, parameters: params)
        let expectedValue = "http://www.example.com"
        XCTAssertEqual(url?.absoluteString, expectedValue, "Expected a url string with no parameters to generate a valid url matching the url string")
    }
    
    func testURLWithSingleParam() {
        let params = ["id": "155"]
        let expectedValue = "http://www.example.com?id=155"
        let url = URL(string: urlString, parameters: params)
        XCTAssertEqual(url?.absoluteString, expectedValue, "Expected a url string with a single parameter to generate a valid url matching the expected format")
    }
    
    func testURLWithTwoParams() {
        let params = ["foo": "true",
                      "bar": "false"]
        let expectedValue = "http://www.example.com?bar=false&foo=true"
        let url = URL(string: urlString, parameters: params)
        XCTAssertEqual(url?.absoluteString, expectedValue, "Expected a url string with two parameters to generate a valid url matching the expected format")
    }
    
    func testURLWithMultipleParams() {
        let params = ["a": "1",
                      "b": "2",
                      "c": "3",
                      "d": "4",
                      "e": "5"]
        let expectedValue = "http://www.example.com?a=1&b=2&c=3&d=4&e=5"
        let url = URL(string: urlString, parameters: params)
        XCTAssertEqual(url?.absoluteString, expectedValue, "Expected a url string with multiple parameters to generate a valid url matching the expected format")
    }
}
