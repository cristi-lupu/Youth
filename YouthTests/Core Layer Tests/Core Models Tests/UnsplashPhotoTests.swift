//
//  UnsplashPhotoTests.swift
//  YouthTests
//
//  Created by Lupu Cristian on 4/25/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import XCTest
@testable import Youth

final class UnsplashPhotoTests: XCTestCase {
    
    private var data: Data?

    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: type(of: self))
        if let url = bundle.url(forResource: "UnsplashPhotoJSON", withExtension: "json") {
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
            let photo = try JSONDecoder().decode(UnsplashPhoto.self, from: data)

            XCTAssertEqual(photo.id,
                           "Dwu85P9SOIk")

            XCTAssertEqual(photo.width,
                           2448)

            XCTAssertEqual(photo.height,
                           3264)

            XCTAssertEqual(photo.hexColor,
                           "#6E633A")

            XCTAssertEqual(photo.downloads,
                           1345)

            XCTAssertEqual(photo.likes,
                           24)

            XCTAssertEqual(photo.likedByUser,
                           false)

            XCTAssertEqual(photo.description,
                           "A man drinking a coffee.")

            XCTAssertNotNil(photo.exif)

            XCTAssertNotNil(photo.location)

            XCTAssertNotNil(photo.relatedCollections)

            XCTAssertNotNil(photo.relatedCollections?[0])

            XCTAssertNotNil(photo.imageURLs)

            XCTAssertNotNil(photo.links)

            XCTAssertNotNil(photo.user)

            XCTAssertNotNil(photo.createdAt)

            XCTAssertNotNil(photo.updatedAt)
        } catch {
            XCTAssert(false, "Failed to decode")
        }
    }
    
}
