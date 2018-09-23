//
//  UnsplashNetworkClient+PhotosRequestTests.swift
//  YouthTests
//
//  Created by Lupu Cristian on 4/28/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import XCTest
@testable import Youth

final class UnsplashNetworkClientPhotosRequesterTests: XCTestCase {
    
    func testPhotosRequest_immediatelyResponse() {
        let networkClient: PhotosNetworkRequester = UnsplashNetworkClient(stubbing: .immediately)
        
        networkClient.photos(page: 1, perPage: 10, orderBy: .latest) { (result) in
            switch result {
            case .success(let payload, _):
                XCTAssert(!payload.isEmpty, "Error stubbing, or in stub JSON 😀")
            case .failure(_):
                XCTAssert(false)
            }
        }
    }
    
}
