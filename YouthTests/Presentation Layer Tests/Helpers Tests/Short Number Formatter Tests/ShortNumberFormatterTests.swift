//
//  ShortNumberFormatterTests.swift
//  YouthTests
//
//  Created by Lupu Cristian on 5/19/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
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
                       formatter.string(from: 1000))
        
        XCTAssertEqual("-1.3K",
                       formatter.string(from: -1284))
        
        XCTAssertEqual("9.9K",
                       formatter.string(from: 9940))
        
        XCTAssertEqual("10K",
                       formatter.string(from: 9980))
        
        XCTAssertEqual("39.9K",
                       formatter.string(from: 39900))
        
        XCTAssertEqual("99.9K",
                       formatter.string(from: 99880))
        
        XCTAssertEqual("0.4M",
                       formatter.string(from: 399880))
        
        XCTAssertEqual("1M",
                       formatter.string(from: 999898))
        
        XCTAssertEqual("1M",
                       formatter.string(from: 999999))
        
        XCTAssertEqual("1.5M",
                       formatter.string(from: 1456384))
        
        XCTAssertEqual("12.4M",
                       formatter.string(from: 12383474))
    }
    
}
