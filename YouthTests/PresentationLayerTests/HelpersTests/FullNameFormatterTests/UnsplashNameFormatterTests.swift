//
//  UnsplashNameFormatterTests.swift
//  YouthTests
//
//  Created by Cristian Lupu on 5/12/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import XCTest
@testable import Youth

final class FullNameFormatterTests: XCTestCase {
    func test_giveOnlyName_shouldReturnName() {
        let name = "Cristian Lupu"
        let fullName = FullNameFormatter().fullName(withName: name, firstName: nil, lastName: nil)
        XCTAssertEqual(name, fullName)
    }

    func test_giveFirstNameAndLastName_shouldReturnFullName() {
        let firstName = "Cristian"
        let lastName = "Lupu"
        let fullName = FullNameFormatter().fullName(withName: nil, firstName: firstName, lastName: lastName)
        XCTAssertEqual(fullName, "Cristian Lupu")
    }

    func test_giveOnlyFirstName_shouldReturnFirstName() {
        let firstName = "Cristian"
        let fullName = FullNameFormatter().fullName(withName: nil, firstName: firstName, lastName: nil)
        XCTAssertEqual(fullName, firstName)
    }

    func test_giveOnlyLastName_shouldReturnLastName() {
        let lastName = "Cristian"
        let fullName = FullNameFormatter().fullName(withName: nil, firstName: nil, lastName: lastName)
        XCTAssertEqual(fullName, lastName)
    }
}
