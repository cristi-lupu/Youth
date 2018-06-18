//
//  UnsplashDateConverterTests.swift
//  YouthTests
//
//  Created by Lupu Cristian on 4/22/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import XCTest
@testable import Youth

final class UnsplashDateConverterTests: XCTestCase {
    
    func testValidDateFromString() {
        let string = "2016-01-12T18:16:09-05:00"
        let date = UnsplashDateConverter.date(from: string)
        XCTAssertNotNil(date)
    }

    func testComponentsDateFromString() {
        let string = "2016-01-12T18:16:09-05:00"

        guard let date = UnsplashDateConverter.date(from: string) else {
            return XCTAssert(false)
        }

        var calendar = Calendar.current
        calendar.timeZone = UnsplashDateConverter.timeZone

        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)

        XCTAssertEqual(day, 12)
        XCTAssertEqual(month, 1)
        XCTAssertEqual(year, 2016)
        XCTAssertEqual(hour, 23)
        XCTAssertEqual(minute, 16)
        XCTAssertEqual(seconds, 9)
    }

    func testValidStringFromDate() {
        let date = Date(timeIntervalSince1970: 1452640569) // Human time (GMT): Tuesday, 12 January 2016 23:16:09
        let stringDate = UnsplashDateConverter.formattedString(from: date)
        XCTAssertEqual(stringDate, "Tue, 12 Jan 2016")
    }
    
}
