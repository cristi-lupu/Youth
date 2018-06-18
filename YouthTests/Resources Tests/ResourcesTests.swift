//
//  ResourcesTests.swift
//  YouthTests
//
//  Created by Lupu Cristian on 5/9/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import XCTest
@testable import Youth

final class YouthResourcesTests: XCTestCase {

    func testValidateResources() {
        do {
            try R.validate()
        } catch {
            XCTFail("Something bad happened with resources")
        }
    }

}
