//
//  UnsplashExifTests.swift
//  YouthTests
//
//  Created by Lupu Cristian on 4/25/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import XCTest
@testable import Youth

final class UnsplashExifTests: XCTestCase {
    
    private var data: Data?
    
    override func setUp() {
        super.setUp()
        
        let bundle = Bundle(for: type(of: self))
        if let url = bundle.url(forResource: "UnsplashExifJSON", withExtension: "json") {
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
            let exif = try JSONDecoder().decode(UnsplashExif.self, from: data)
            
            XCTAssertEqual(exif.make,
                           "Canon")
            
            XCTAssertEqual(exif.model,
                           "Canon EOS 40D")
            
            XCTAssertEqual(exif.exposureTime,
                           "0.011111111111111112")
            
            XCTAssertEqual(exif.aperture,
                           "4.970854")
            
            XCTAssertEqual(exif.focalLength,
                           "37")
            
            XCTAssertEqual(exif.iso,
                           100)
        } catch {
            XCTAssert(false, "Failed to decode")
        }
    }
    
}
