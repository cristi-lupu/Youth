//
//  UnsplashSearchPhotosRequestTests.swift
//  YouthTests
//
//  Created by Cristian Lupu on 10/27/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

@testable import Moya
@testable import RxSwift
import XCTest
@testable import Youth

final class UnsplashSearchPhotosRequestTests: XCTestCase {
    var provider: MoyaProvider<Unsplash.SearchRequestComposer>!

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
        userSearchPhotosRequestObservable
            .always { expectation.fulfill() }
            .onSuccess { _ in XCTAssert(true) }
            .unsplashOnFailure { _ in XCTFail("UnsplashSearchPhotosRequest error") }
            .run()
        wait(for: [expectation], timeout: 0.5)
    }

    // swiftlint:disable:next line_length
    private var userSearchPhotosRequestObservable: Observable<Unsplash.Response<Unsplash.SearchResult<Unsplash.Photo>>> {
        return provider
            .unsplashRequest(
                Unsplash.SearchRequestComposer(
                    Unsplash.SearchPhotosRequest(query: "someQuery", pagination: .init(page: 1, perPage: 2))
                )
        )
    }
}
