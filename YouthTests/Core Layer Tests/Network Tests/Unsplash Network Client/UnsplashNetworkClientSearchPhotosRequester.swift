//
//  UnsplashNetworkClientSearchPhotosRequester.swift
//  YouthTests
//
//  Created by Cristian Lupu on 6/2/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import XCTest
@testable import Youth

final class UnsplashNetworkClientSearchPhotosRequester: XCTestCase {
    
    func testSearchPhotosRequest_immediatelyResponse() {
        let networkClient: SearchPhotosNetworkRequester = UnsplashNetworkClient(stubbing: .immediately)
        
        networkClient.searchPhotos(query: "some query", page: 1, perPage: 30) { (result) in
            switch result {
            case let .success(payload, _):
                XCTAssert(!payload.results.isEmpty)
            case .failure(_):
                XCTAssert(false)
            }
        }
    }
    
}
