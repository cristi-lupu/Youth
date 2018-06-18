//
//  UnsplashBadge.swift
//  Youth
//
//  Created by Lupu Cristian on 4/22/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

public struct UnsplashBadge {

    public let title: String?
    public let isPrimary: Bool?
    public let slug: String?
    public let link: URL?

}

extension UnsplashBadge: Decodable {

    private enum CodingKeys: String, CodingKey {
        case title
        case isPrimary = "primary"
        case slug
        case link
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.isPrimary = try container.decodeIfPresent(Bool.self, forKey: .isPrimary)
        self.slug = try container.decodeIfPresent(String.self, forKey: .slug)
        self.link = try container.decodeIfPresent(URL.self, forKey: .link)
    }

}
