//
//  UnsplashNetworkClient+UserPublicProfileTests.swift
//  YouthTests
//
//  Created by Lupu Cristian on 5/22/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import XCTest
@testable import Youth

final class UnsplashNetworkClientUserPublicProfileRequesterTests: XCTestCase {
    
    func testUserPublicProfileRequest_immediatelyResponse() {
        let networkClient: UserPublicProfileNetworkRequester = UnsplashNetworkClient(stubbing: .immediately)
        
        networkClient.userPublicProfile(username: "someName") { (result) in
            switch result {
            case .success:
                XCTAssert(true)
            case .failure:
                XCTAssert(false)
            }
        }
    }
    
}
