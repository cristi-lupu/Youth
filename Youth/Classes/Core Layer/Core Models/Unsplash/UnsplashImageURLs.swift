//
//  UnsplashImageURLs.swift
//  Youth
//
//  Created by Lupu Cristian on 4/22/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

/**
 Struct which contains all urls to image sources
 */
struct UnsplashImageURLs {
    
    let raw: URL?
    let full: URL?
    let regular: URL?
    let small: URL?
    let thumb: URL?
    
}

// MARK: Decodable

extension UnsplashImageURLs: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case raw
        case full
        case regular
        case small
        case thumb
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.raw = try container.decodeIfPresent(URL.self, forKey: .raw)
        self.full = try container.decodeIfPresent(URL.self, forKey: .full)
        self.regular = try container.decodeIfPresent(URL.self, forKey: .regular)
        self.small = try container.decodeIfPresent(URL.self, forKey: .small)
        self.thumb = try container.decodeIfPresent(URL.self, forKey: .thumb)
    }
    
}

