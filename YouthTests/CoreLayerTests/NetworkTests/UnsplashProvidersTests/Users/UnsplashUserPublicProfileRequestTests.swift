//
//  UnsplashUserPublicProfileRequestTests.swift
//  YouthTests
//
//  Created by Cristian Lupu on 10/25/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

@testable import Moya
@testable import RxSwift
import XCTest
@testable import Youth

final class UnsplashUserPublicProfileRequestTests: XCTestCase {
    var provider: MoyaProvider<Unsplash.UsersRequestComposer>!

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
        userPublicProfileRequestObservable
            .always { expectation.fulfill() }
            .onSuccess { _ in XCTAssert(true) }
            .unsplashOnFailure { _ in XCTFail("UnsplashUserPublicProfileRequest error") }
            .run()
        wait(for: [expectation], timeout: 0.5)
    }

    private var userPublicProfileRequestObservable: Observable<Unsplash.Response<Unsplash.User>> {
        return provider
            .unsplashRequest(
                Unsplash.UsersRequestComposer(
                    Unsplash.UserPublicProfileRequest(username: "")
                )
        )
    }
}
