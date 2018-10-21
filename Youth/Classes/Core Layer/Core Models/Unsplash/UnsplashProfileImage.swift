//
//  UnsplashProfileImage.swift
//  Youth
//
//  Created by Cristian Lupu on 4/22/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

/// Profile image URLs
struct UnsplashProfileImage {
    /// Small size image URL
    let small: URL?

    /// Medium size image URL
    let medium: URL?

    /// Large size image URL
    let large: URL?
}

// MARK: Decodable

extension UnsplashProfileImage: Decodable {
    private enum CodingKeys: String, CodingKey {
        case small
        case medium
        case large
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.small = try container.decodeIfPresent(URL.self, forKey: .small)
        self.medium = try container.decodeIfPresent(URL.self, forKey: .medium)
        self.large = try container.decodeIfPresent(URL.self, forKey: .large)
    }
}
