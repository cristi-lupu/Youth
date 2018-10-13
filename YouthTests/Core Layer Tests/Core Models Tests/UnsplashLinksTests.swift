//
//  UnsplashLinksTests.swift
//  YouthTests
//
//  Created by Cristian Lupu on 4/25/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import XCTest
@testable import Youth

final class UnsplashLinksTests: XCTestCase {
    
    private var data: Data?
    
    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: type(of: self))
        if let url = bundle.url(forResource: "UnsplashLinksJSON", withExtension: "json") {
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
            let links = try JSONDecoder().decode(UnsplashLinks.self, from: data)
            
            XCTAssertEqual(links.`self`?.absoluteString,
                           "https://api.unsplash.com/users/alex19perz")
            
            XCTAssertEqual(links.html?.absoluteString,
                           "https://unsplash.com/@alex19perz")
            
            XCTAssertEqual(links.photos?.absoluteString,
                           "https://api.unsplash.com/users/alex19perz/photos")
            
            XCTAssertEqual(links.likes?.absoluteString,
                           "https://api.unsplash.com/users/alex19perz/likes")
            
            XCTAssertEqual(links.portfolio?.absoluteString,
                           "https://api.unsplash.com/users/alex19perz/portfolio")
            
            XCTAssertEqual(links.following?.absoluteString,
                           "https://api.unsplash.com/users/alex19perz/following")
            
            XCTAssertEqual(links.followers?.absoluteString,
                           "https://api.unsplash.com/users/alex19perz/followers")
            
            XCTAssertEqual(links.download?.absoluteString,
                           "https://unsplash.com/photos/5zFxCK_p6So/download")
            
            XCTAssertEqual(links.downloadLocation?.absoluteString,
                           "https://api.unsplash.com/photos/5zFxCK_p6So/download")
        } catch {
            XCTAssert(false, "Failed to decode")
        }
    }
    
}
