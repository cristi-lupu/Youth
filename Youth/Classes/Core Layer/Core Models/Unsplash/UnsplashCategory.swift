//
//  UnsplashCategory.swift
//  Youth
//
//  Created by Lupu Cristian on 4/22/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

public struct UnsplashCategory {

    public let id: Int64?
    public let exposureTime: String?
    public let photoCount: Int64?
    public let links: UnsplashLinks?

}

extension UnsplashCategory: Decodable {

    private enum CodingKeys: String, CodingKey {
        case id
        case exposureTime = "exposure_time"
        case photoCount = "photo_count"
        case links
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int64.self, forKey: .id)
        self.exposureTime = try container.decodeIfPresent(String.self, forKey: .exposureTime)
        self.photoCount = try container.decodeIfPresent(Int64.self, forKey: .photoCount)
        self.links = try container.decodeIfPresent(UnsplashLinks.self, forKey: .links)
    }

}
