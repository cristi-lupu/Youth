//
//  UnsplashNetworkClient+PhotoRequestTest.swift
//  YouthTests
//
//  Created by Lupu Cristian on 6/15/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import XCTest
@testable import Youth

final class UnsplashNetworkClientPhotoRequesterTests: XCTestCase {
    
    func testPhotoRequest_immediatelyResponse() {
        let networkClient: PhotoNetworkRequester = UnsplashNetworkClient(stubbing: .immediately)
        
        networkClient.photo(id: "someID") { (result) in
            switch result {
            case .success(_, _):
                XCTAssert(true)
            case .failure(_):
                XCTAssert(false)
            }
        }
    }
    
}
