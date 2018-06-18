//
//  UnsplashProfileImageTests.swift
//  YouthTests
//
//  Created by Lupu Cristian on 4/25/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import XCTest
@testable import Youth

final class UnsplashProfileImageTests: XCTestCase {

    private var data: Data?
    
    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: type(of: self))
        if let url = bundle.url(forResource: "UnsplashProfileImageJSON", withExtension: "json") {
            self.data = try? Data(contentsOf: url)
        }
    }
    
    override func tearDown() {
        data = nil
        super.tearDown()
    }

    func testMapping() {
        guard let data = self.data else {
            XCTAssert(false, "Failed load json")
            return
        }

        do {
            let profileImage = try JSONDecoder().decode(UnsplashProfileImage.self, from: data)

            XCTAssertEqual(profileImage.small?.absoluteString,
                           "https://images.unsplash.com/face-springmorning.jpg?q=80&fm=jpg&crop=faces&fit=crop&h=32&w=32")

            XCTAssertEqual(profileImage.medium?.absoluteString,
                           "https://images.unsplash.com/face-springmorning.jpg?q=80&fm=jpg&crop=faces&fit=crop&h=64&w=64")

            XCTAssertEqual(profileImage.large?.absoluteString,
                           "https://images.unsplash.com/face-springmorning.jpg?q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128")
        } catch {
            XCTAssert(false, "Failed to decode")
        }
    }
    
}
