//
//  UnsplashPhotoRequest.swift
//  YouthTests
//
//  Created by Cristian Lupu on 10/25/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

@testable import Moya
@testable import RxSwift
import XCTest
@testable import Youth

final class UnsplashPhotoRequestTests: XCTestCase {
    var provider: MoyaProvider<Unsplash.PhotosRequestComposer>!

    override func setUp() {
        super.setUp()

        provider = MoyaProvider(stubClosure: MoyaProvider.immediatelyStub)
    }

    override func tearDown() {
        provider = nil

        super.tearDown()
    }

    func test_requestResponseDecoding_shouldPass() {
        let expectation = XCTestExpectation(description: "Response expection")
        photoRequestObservable
            .always { expectation.fulfill() }
            .onSuccess { _ in XCTAssert(true) }
            .unsplashOnFailure { _ in XCTFail("UnsplashPhotoRequest error") }
            .run()
        wait(for: [expectation], timeout: 0.5)
    }

    private var photoRequestObservable: Observable<Unsplash.Response<Unsplash.Photo>> {
        return provider
            .unsplashRequest(
                Unsplash.PhotosRequestComposer(
                    Unsplash.PhotoRequest(photoID: "someID")
                )
            )
    }
}
