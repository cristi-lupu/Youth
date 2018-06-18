//
//  UnsplashProfileImage.swift
//  Youth
//
//  Created by Lupu Cristian on 4/22/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

/// Profile image URLs
public struct UnsplashProfileImage {

    /// Small size image URL
    public let small: URL?

    /// Medium size image URL
    public let medium: URL?

    /// Large size image URL
    public let large: URL?
}

// MARK: Decodable

extension UnsplashProfileImage: Decodable {

    private enum CodingKeys: String, CodingKey {
        case small
        case medium
        case large
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.small = try container.decodeIfPresent(URL.self, forKey: .small)
        self.medium = try container.decodeIfPresent(URL.self, forKey: .medium)
        self.large = try container.decodeIfPresent(URL.self, forKey: .large)
    }

}
