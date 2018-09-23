//
//  PhotoProviderTests.swift
//  YouthTests
//
//  Created by Lupu Cristian on 6/18/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import XCTest
@testable import Youth

final class PhotoProviderTests: XCTestCase {
    
    var provider: PhotoProvider!
    
    override func setUp() {
        super.setUp()
        
        let networkClient = UnsplashNetworkClient(stubbing: .immediately)
        provider = PhotoProvider(networkClient: networkClient)
    }
    
    override func tearDown() {
        provider = nil
        
        super.tearDown()
    }
    
    func testGettingPhoto() {
        provider.photo(id: "someID", usage: .network) { (result) in
            switch result {
            case .success:
                XCTAssert(true)
            case .failure:
                XCTAssert(false)
            }
        }
        
    }
    
}
