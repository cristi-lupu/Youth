//
//  UnsplashImageURLsTests.swift
//  YouthTests
//
//  Created by Cristian Lupu on 4/25/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import XCTest
@testable import Youth

final class UnsplashImageURLsTests: XCTestCase {
    
    private var data: Data?
    
    override func setUp() {
        super.setUp()
        
        let bundle = Bundle(for: type(of: self))
        if let url = bundle.url(forResource: "UnsplashImageURLsJSON", withExtension: "json"){
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
            let imageURLs = try JSONDecoder().decode(UnsplashImageURLs.self, from: data)
            
            XCTAssertEqual(imageURLs.raw?.absoluteString,
                           "https://images.unsplash.com/photo-1524356750934-a53b36db5ea3?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjI1MTE2fQ&s=d3a3f0077115d6c70e095fb5146ec508")
            
            XCTAssertEqual(imageURLs.full?.absoluteString,
                           "https://images.unsplash.com/photo-1524356750934-a53b36db5ea3?ixlib=rb-0.3.5&q=85&fm=jpg&crop=entropy&cs=srgb&ixid=eyJhcHBfaWQiOjI1MTE2fQ&s=9c3eb44c3c549e4fbd69d41e089b8e31")
            
            XCTAssertEqual(imageURLs.regular?.absoluteString,
                           "https://images.unsplash.com/photo-1524356750934-a53b36db5ea3?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjI1MTE2fQ&s=dc61864e2b610109cd7d1b07c77b9837")
            
            XCTAssertEqual(imageURLs.small?.absoluteString,
                           "https://images.unsplash.com/photo-1524356750934-a53b36db5ea3?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max&ixid=eyJhcHBfaWQiOjI1MTE2fQ&s=c335ed03413e47b9e7aacdd7edfbc8d9")
            
            XCTAssertEqual(imageURLs.thumb?.absoluteString,
                           "https://images.unsplash.com/photo-1524356750934-a53b36db5ea3?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&ixid=eyJhcHBfaWQiOjI1MTE2fQ&s=0c92007415127c3db65e4dfe2420becb")
        } catch {
            XCTAssert(false, "Failed to decode")
        }
    }
    
}
