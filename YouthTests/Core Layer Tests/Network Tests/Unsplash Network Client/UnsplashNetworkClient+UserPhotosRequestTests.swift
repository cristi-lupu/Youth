//
//  UnsplashNetworkClient+UserPhotosRequestTests.swift
//  YouthTests
//
//  Created by User678 on 5/25/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import XCTest
@testable import Youth

final class UnsplashNetworkClientUserPhotosRequesterTests: XCTestCase {
    
    func testUserPhotosRequest_immediatelyResponse() {
        let networkClient: UserPhotosNetworkRequester = UnsplashNetworkClient(stubbing: .immediately)

        networkClient.userPhotos(username: "someUsername",
                                 page: 1,
                                 perPage: 30,
                                 orderBy: .latest,
                                 includeStats: true) { (result) in
                                    switch result {
                                    case .success:
                                        XCTAssert(true)
                                    case .failure:
                                        XCTAssert(false)
                                    }
        }
    }
    
}
