//
//  UnsplashImageURLs.swift
//  Youth
//
//  Created by Cristian Lupu on 4/22/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

extension Unsplash {
    /**
     Struct which contains all urls to image sources
     */
    struct ImageURLs: Decodable {
        let raw: URL?
        let full: URL?
        let regular: URL?
        let small: URL?
        let thumb: URL?

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
}
