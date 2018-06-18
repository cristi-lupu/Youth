//
//  UnsplashNameFormatterTests.swift
//  YouthTests
//
//  Created by Lupu Cristian on 5/12/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import XCTest
@testable import Youth

final class FullNameFormatterTests: XCTestCase {

    func testReturningName() {
        let name = "Lupu Cristian"

        let fullName = FullNameFormatter().fullName(withName: name, firstName: nil, lastName: nil)

        XCTAssertEqual(name,
                       fullName)
    }

    func testReturningFullName() {
        let firstName = "Cristian"
        let lastName = "Lupu"

        let fullName = FullNameFormatter().fullName(withName: nil, firstName: firstName, lastName: lastName)

        XCTAssertEqual(fullName,
                       "Cristian Lupu")
    }

    func testReturningOnlyFirstName() {
        let firstName = "Cristian"

        let fullName = FullNameFormatter().fullName(withName: nil, firstName: firstName, lastName: nil)

        XCTAssertEqual(fullName,
                       firstName)
    }

    func testReturninOnlyLastName() {
        let lastName = "Cristian"

        let fullName = FullNameFormatter().fullName(withName: nil, firstName: nil, lastName: lastName)

        XCTAssertEqual(fullName,
                       lastName)
    }

}
