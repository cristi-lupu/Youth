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
public struct UnsplashImageURLs {

    public let raw: URL?
    public let full: URL?
    public let regular: URL?
    public let small: URL?
    public let thumb: URL?

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

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.raw = try container.decodeIfPresent(URL.self, forKey: .raw)
        self.full = try container.decodeIfPresent(URL.self, forKey: .full)
        self.regular = try container.decodeIfPresent(URL.self, forKey: .regular)
        self.small = try container.decodeIfPresent(URL.self, forKey: .small)
        self.thumb = try container.decodeIfPresent(URL.self, forKey: .thumb)
    }

}

