//
//  UnsplashLocationTests.swift
//  YouthTests
//
//  Created by Lupu Cristian on 4/25/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import XCTest
@testable import Youth

final class UnsplashLocationTests: XCTestCase {
    
    private var data: Data?
    
    override func setUp() {
        super.setUp()
        
        let bundle = Bundle(for: type(of: self))
        if let url = bundle.url(forResource: "UnsplashLocationJSON", withExtension: "json") {
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
            let location = try JSONDecoder().decode(UnsplashLocation.self, from: data)
            
            XCTAssertEqual(location.city,
                           "Montreal")
            
            XCTAssertEqual(location.country,
                           "Canada")
            
            XCTAssertEqual(location.position?.latitude,
                           45.4732984)
            
            XCTAssertEqual(location.position?.longitude,
                           -73.6384879)
        } catch {
            XCTAssert(false, "Failed to decode")
        }
    }
    
}
