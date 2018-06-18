//
//  UnsplashBadgeTests.swift
//  YouthTests
//
//  Created by Lupu Cristian on 4/25/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import XCTest
@testable import Youth

final class UnsplashBadgeTests: XCTestCase {

    private var data: Data?
    
    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: type(of: self))
        if let url = bundle.url(forResource: "UnsplashBadgeJSON", withExtension: "json") {
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
            let badge = try JSONDecoder().decode(UnsplashBadge.self, from: data)

            XCTAssertEqual(badge.title,
                           "Book contributor")

            XCTAssertEqual(badge.isPrimary,
                           true)

            XCTAssertNotNil(badge.slug,
                            "book-contributor")

            XCTAssertEqual(badge.link?.absoluteString,
                           "https://book.unsplash.com")
        } catch {
            XCTAssert(false, "Failed to decode")
        }
    }
    
}
