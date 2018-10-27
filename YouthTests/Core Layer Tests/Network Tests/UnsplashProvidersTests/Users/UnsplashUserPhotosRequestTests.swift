//
//  UnsplashUserPhotosRequestTests.swift
//  YouthTests
//
//  Created by Cristian Lupu on 10/25/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

@testable import Moya
@testable import RxSwift
import XCTest
@testable import Youth

final class UnsplashUserPhotosRequestTests: XCTestCase {
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
        userPhotosRequestObservable
            .always { expectation.fulfill() }
            .onSuccess { _ in  XCTAssert(true) }
            .unsplashOnFailure { _ in XCTFail("UnsplashUserPhotosRequest error") }
            .run()
        wait(for: [expectation], timeout: 0.5)
    }

    private var userPhotosRequestObservable: Observable<Unsplash.Response<[Unsplash.Photo]>> {
        return provider
            .unsplashRequest(
                Unsplash.UsersRequestComposer(
                    Unsplash.UserPhotosRequest(username: "", pagination: .init(page: 1, perPage: 2, orderBy: .latest))
                )
        )
    }
}
