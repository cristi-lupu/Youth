//
//  UnsplashCategory.swift
//  Youth
//
//  Created by Cristian Lupu on 4/22/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

extension Unsplash {
    struct Category: Decodable {
        let id: Int64?
        let exposureTime: String?
        let photoCount: Int64?
        let links: Links?

        private enum CodingKeys: String, CodingKey {
            case id
            case exposureTime = "exposure_time"
            case photoCount = "photo_count"
            case links
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decodeIfPresent(Int64.self, forKey: .id)
            self.exposureTime = try container.decodeIfPresent(String.self, forKey: .exposureTime)
            self.photoCount = try container.decodeIfPresent(Int64.self, forKey: .photoCount)
            self.links = try container.decodeIfPresent(Links.self, forKey: .links)
        }
    }
}
