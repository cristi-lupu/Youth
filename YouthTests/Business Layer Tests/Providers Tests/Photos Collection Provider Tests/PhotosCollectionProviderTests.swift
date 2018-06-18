//
//  PhotosCollectionProviderTests.swift
//  YouthTests
//
//  Created by Lupu Cristian on 6/18/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import XCTest
@testable import Youth

final class PhotosCollectionProviderTests: XCTestCase {

    var provider: PhotosCollectionProvider!

    override func setUp() {
        super.setUp()
        let networkClient = UnsplashNetworkClient(stubbing: .immediately)
        provider = PhotosCollectionProvider(networkClient: networkClient)
    }

    override func tearDown() {
        provider = nil
        super.tearDown()
    }

    func testGettingPhotos() {
        provider.photos(page: 1, perPage: 30, orderBy: .latest, usage: .network) { (result) in
            switch result {
            case .success(let payload):
                XCTAssert(!payload.isEmpty)
            case .failure(_):
                XCTAssert(false)
            }
        }
    }

    func testGettingUserPhotos() {
        provider.userPhotos(username: "someUsername", page: 1, perPage: 30, orderBy: .latest, usage: .network) { (result) in
            switch result {
            case .success(let payload):
                XCTAssert(!payload.isEmpty)
            case .failure(_):
                XCTAssert(false)
            }
        }
    }

    func testGettingUserLikedPhotos() {
        provider.userLikedPhotos(username: "someUsername", page: 1, perPage: 30, orderBy: .latest, usage: .network) { (result) in
            switch result {
            case .success(let payload):
                XCTAssert(!payload.isEmpty)
            case .failure(_):
                XCTAssert(false)
            }
        }
    }

    func testGettingSearchPhotosOnQuery() {
        provider.searchPhotos(query: "someQuery", page: 1, perPage: 30, usage: .network) { (result) in
            switch result {
            case .success(let payload):
                XCTAssert(!payload.isEmpty)
            case .failure(_):
                XCTAssert(false)
            }
        }
    }

}
