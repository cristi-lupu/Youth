//
//  ShortNumberFormatterTests.swift
//  YouthTests
//
//  Created by Cristian Lupu on 5/19/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import XCTest
@testable import Youth

final class ShortNumberFormatterTests: XCTestCase {
    
    func testExpectedResults() {
        let formatter = ShortNumberFormatter()
        
        XCTAssertEqual("598",
                       formatter.string(from: 598))
        
        XCTAssertEqual("-999",
                       formatter.string(from: -999))
        
        XCTAssertEqual("1K",
                       formatter.string(from: 1_000))
        
        XCTAssertEqual("-1.3K",
                       formatter.string(from: -1_284))
        
        XCTAssertEqual("9.9K",
                       formatter.string(from: 9_940))
        
        XCTAssertEqual("10K",
                       formatter.string(from: 9_980))
        
        XCTAssertEqual("39.9K",
                       formatter.string(from: 39_900))
        
        XCTAssertEqual("99.9K",
                       formatter.string(from: 99_880))
        
        XCTAssertEqual("0.4M",
                       formatter.string(from: 399_880))
        
        XCTAssertEqual("1M",
                       formatter.string(from: 999_898))
        
        XCTAssertEqual("1M",
                       formatter.string(from: 999_999))
        
        XCTAssertEqual("1.5M",
                       formatter.string(from: 1_456_384))
        
        XCTAssertEqual("12.4M",
                       formatter.string(from: 12_383_474))
    }
    
}
