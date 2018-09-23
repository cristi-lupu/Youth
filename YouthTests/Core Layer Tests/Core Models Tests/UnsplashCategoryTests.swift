//
//  UnsplashCategoryTests.swift
//  YouthTests
//
//  Created by Lupu Cristian on 4/25/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import XCTest
@testable import Youth

final class UnsplashCategoryTests: XCTestCase {
    
    private var data: Data?
    
    override func setUp() {
        super.setUp()
        
        let bundle = Bundle(for: type(of: self))
        if let url = bundle.url(forResource: "UnsplashCategoryJSON", withExtension: "json") {
            self.data = try? Data(contentsOf: url)
        }
    }
    
    override func tearDown() {
        data = nil
        
        super.tearDown()
    }
    
    func testMapping() {
        guard let data = self.data else {
            XCTAssert(false, "Failed load json")
            return
        }
        
        do {
            let category = try JSONDecoder().decode(UnsplashCategory.self, from: data)
            
            XCTAssertEqual(category.id,
                           345)
            
            XCTAssertEqual(category.exposureTime,
                           "some-exposure_time")
            
            XCTAssertEqual(category.photoCount,
                           33)
            
            XCTAssertNotNil(category.links)
        } catch {
            XCTAssert(false, "Failed to decode")
        }
    }
    
}
