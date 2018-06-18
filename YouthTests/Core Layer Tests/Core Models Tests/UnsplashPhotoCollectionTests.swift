//
//  UnsplashPhotoCollectionTests.swift
//  YouthTests
//
//  Created by Lupu Cristian on 4/25/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import XCTest
@testable import Youth

final class UnsplashPhotoCollectionTests: XCTestCase {
    
    private var data: Data?

    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: type(of: self))
        if let url = bundle.url(forResource: "UnsplashPhotoCollectionJSON", withExtension: "json") {
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
            let collection = try JSONDecoder().decode(UnsplashPhotoCollection.self, from: data)

            XCTAssertEqual(collection.id,
                           206)

            XCTAssertEqual(collection.title,
                           "Makers: Cat and Ben")

            XCTAssertNotNil(collection.publishedAt)

            XCTAssertNotNil(collection.updatedAt)

            XCTAssertEqual(collection.isCurated,
                           false)

            XCTAssertNotNil(collection.coverPhoto)

            XCTAssertNotNil(collection.user)

            XCTAssertNotNil(collection.links)
        } catch {
            XCTAssert(false, "Failed to decode")
        }
    }
    
}
