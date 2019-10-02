//
//  UsernameFormatterTests.swift
//  YouthTests
//
//  Created by Cristian Lupu on 5/22/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import XCTest
@testable import Youth

final class UsernameFormatterTests: XCTestCase {
    func testReturningWithAmpersandSuffix() {
        let formatter = UsernameFormatter()
        XCTAssertEqual(formatter.formattedUsername("someUsername"), "@someUsername")
    }

    func testReturningTheSameUsername() {
        let formatter = UsernameFormatter()
        XCTAssertEqual(formatter.formattedUsername("@usernameWithAmpersandSuffix"), "@usernameWithAmpersandSuffix")
    }
}
