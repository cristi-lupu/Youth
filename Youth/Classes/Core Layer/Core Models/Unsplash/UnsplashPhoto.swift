//
//  UnsplashPhoto.swift
//  Youth
//
//  Created by Lupu Cristian on 4/22/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

/**
 Unsplash Photo Object
 */
public struct UnsplashPhoto {
    /// Identifier
    public let id: String?

    /// Create at (date)
    public let createdAt: Date?

    /// Updated at (date)
    public let updatedAt: Date?

    /// Width size
    public let width: Int?

    /// Height size
    public let height: Int?

    /// Hex Color
    public let hexColor: String?

    /// Total likes
    public let likes: Int64?

    /// Is liked by user
    public let likedByUser: Bool?

    /// About
    public let description: String?

    /// Collections It Belongs
    public let relatedCollections: [UnsplashPhotoCollection]?

    /// User
    public let user: UnsplashUser?

    /// Image URLs
    public let imageURLs: UnsplashImageURLs?

    /// Links
    public let links: UnsplashLinks?

    /// Is sponsored
    public let isSponsored: Bool?

    /// Categories
    public let categories: [UnsplashCategory]?

    /// Exif. Photo Metadata
    public let exif: UnsplashExif?

    /// Location
    public let location: UnsplashLocation?

    /// Downloads Count
    public let downloads: Int64?

}

// MARK: Decodable

extension UnsplashPhoto: Decodable {

    private enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case width
        case height
        case hexColor = "color"
        case likes
        case likedByUser = "liked_by_user"
        case description
        case relatedCollections = "current_user_collections"
        case user
        case imageURLs = "urls"
        case links
        case isSponsored = "sponsored"
        case categories
        case exif
        case location
        case downloads
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)

        let createdAtString = try container.decodeIfPresent(String.self, forKey: .createdAt)
        self.createdAt = UnsplashDateConverter.date(from: createdAtString)

        let updatedAtString = try container.decodeIfPresent(String.self, forKey: .updatedAt)
        self.updatedAt = UnsplashDateConverter.date(from: updatedAtString)

        self.width = try container.decodeIfPresent(Int.self, forKey: .width)
        self.height = try container.decodeIfPresent(Int.self, forKey: .height)
        self.hexColor = try container.decodeIfPresent(String.self, forKey: .hexColor)
        self.likes = try container.decodeIfPresent(Int64.self, forKey: .likes)
        self.likedByUser = try container.decodeIfPresent(Bool.self, forKey: .likedByUser)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.relatedCollections = try container.decodeIfPresent([UnsplashPhotoCollection].self, forKey: .relatedCollections)
        self.user = try container.decodeIfPresent(UnsplashUser.self, forKey: .user)
        self.imageURLs = try container.decodeIfPresent(UnsplashImageURLs.self, forKey: .imageURLs)
        self.links = try container.decodeIfPresent(UnsplashLinks.self, forKey: .links)
        self.isSponsored = try container.decodeIfPresent(Bool.self, forKey: .isSponsored)
        self.categories = try container.decodeIfPresent([UnsplashCategory].self, forKey: .categories)
        self.exif = try container.decodeIfPresent(UnsplashExif.self, forKey: .exif)
        self.location = try container.decodeIfPresent(UnsplashLocation.self, forKey: .location)
        self.downloads = try container.decodeIfPresent(Int64.self, forKey: .downloads)
    }

}
