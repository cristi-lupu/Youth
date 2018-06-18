//
//  UsernameFormatterTests.swift
//  YouthTests
//
//  Created by Lupu Cristian on 5/22/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import XCTest
@testable import Youth

final class UsernameFormatterTests: XCTestCase {

    func testReturningWithAmpersandSuffix() {
        let formatter = UsernameFormatter()

        XCTAssertEqual(formatter.formattedUsername("someUsername"),
                       "@someUsername")
    }

    func testReturningTheSameUsername() {
        let formatter = UsernameFormatter()

        XCTAssertEqual(formatter.formattedUsername("@usernameWithAmpersandSuffix"),
                       "@usernameWithAmpersandSuffix")
    }
    
}
