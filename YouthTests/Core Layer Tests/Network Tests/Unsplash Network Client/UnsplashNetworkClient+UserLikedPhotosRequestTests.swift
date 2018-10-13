//
//  UnsplashNetworkClient+UserLikedPhotosRequestTests.swift
//  YouthTests
//
//  Created by Cristian Lupu on 5/25/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import XCTest
@testable import Youth

final class UnsplashNetworkClientUserLikedPhotosRequesterTests: XCTestCase {
    
    func testUserLikedPhotosRequest_immediatelyResponse() {
        let networkClient: UserLikedPhotosNetworkRequester = UnsplashNetworkClient(stubbing: .immediately)
        
        networkClient.userLikedPhotos(username: "someUsername",
                                      page: 1,
                                      perPage: 30,
                                      orderBy: .latest) { (result) in
                                        switch result {
                                        case .success:
                                            XCTAssert(true)
                                        case .failure:
                                            XCTAssert(false)
                                        }
        }
    }
    
}
