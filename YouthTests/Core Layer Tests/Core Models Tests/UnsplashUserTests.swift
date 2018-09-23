//
//  UnsplashUserTests.swift
//  YouthTests
//
//  Created by Lupu Cristian on 4/25/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import XCTest
@testable import Youth

final class UnsplashUserTests: XCTestCase {
    
    private var data: Data?
    
    override func setUp() {
        super.setUp()
        
        let bundle = Bundle(for: type(of: self))
        if let url = bundle.url(forResource: "UnsplashUserJSON", withExtension: "json") {
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
            let user = try JSONDecoder().decode(UnsplashUser.self, from: data)
            
            XCTAssertEqual(user.id,
                           "pXhwzz1JtQU")
            
            XCTAssertEqual(user.username,
                           "jimmyexample")
            
            XCTAssertEqual(user.firstName,
                           "James")
            
            XCTAssertEqual(user.lastName,
                           "Example")
            
            XCTAssertNil(user.name)
            
            XCTAssertNotNil(user.updatedAt)
            
            XCTAssertEqual(user.twitterUsername,
                           "jimmy")
            
            XCTAssertEqual(user.bio,
                           "The user's bio")
            
            XCTAssertEqual(user.location,
                           "Montreal, Qc")
            
            XCTAssertEqual(user.totalLikes,
                           20)
            
            XCTAssertEqual(user.totalPhotos,
                           10)
            
            XCTAssertEqual(user.totalCollections,
                           5)
            
            XCTAssertEqual(user.followedByUser,
                           false)
            
            XCTAssertEqual(user.downloads,
                           4321)
            
            XCTAssertEqual(user.uploadsRemaining,
                           4)
            
            XCTAssertEqual(user.instagramUsername,
                           "james-example")
            
            XCTAssertEqual(user.email,
                           "jim@example.com")
            
            XCTAssertEqual(user.followersCount,
                           300)
            
            XCTAssertEqual(user.followingCount,
                           25)
            
            XCTAssertNotNil(user.links)
            
            XCTAssertNotNil(user.profileImage)
            
            XCTAssertNotNil(user.badge)
        } catch {
            XCTAssert(false, "Failed to decode")
        }
    }
    
}
