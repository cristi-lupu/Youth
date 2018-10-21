//
//  UnsplashPhotoCollection.swift
//  Youth
//
//  Created by Cristian Lupu on 4/22/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

/// Photo Collection Object
struct UnsplashPhotoCollection {
    /// Identifier
    let id: Int64?

    /// Title
    let title: String?

    /// Published at (date)
    let publishedAt: Date?

    /// Updated at (date)
    let updatedAt: Date?

    /// Is curated
    let isCurated: Bool?

    /// Is featured
    let isFeatured: Bool?

    /// Is private
    let isPrivate: Bool?

    /// Cover Photo
    let coverPhoto: UnsplashPhoto?

    /// User
    let user: UnsplashUser?

    /// Links
    let links: UnsplashLinks?

    /// Share Key
    let shareKey: String?

    /// Total Photos
    let totalPhotos: Int64?

    /// Description
    let description: String?
}

/// MARK: Decodable

extension UnsplashPhotoCollection: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case publishedAt = "published_at"
        case updatedAt = "updated_at"
        case isCurated = "curated"
        case isFeatured = "featured"
        case isPrivate = "private"
        case coverPhoto = "cover_photo"
        case user
        case links
        case shareKey = "share_key"
        case totalPhotos = "total_photos"
        case description
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int64.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)

        let publishedAtString = try container.decodeIfPresent(String.self, forKey: .publishedAt)
        self.publishedAt = UnsplashDateConverter.date(from: publishedAtString)

        let updatedAtString = try container.decodeIfPresent(String.self, forKey: .updatedAt)
        self.updatedAt = UnsplashDateConverter.date(from: updatedAtString)

        self.isCurated = try container.decodeIfPresent(Bool.self, forKey: .isCurated)
        self.isFeatured = try container.decodeIfPresent(Bool.self, forKey: .isFeatured)
        self.isPrivate = try container.decodeIfPresent(Bool.self, forKey: .isPrivate)
        self.coverPhoto = try container.decodeIfPresent(UnsplashPhoto.self, forKey: .coverPhoto)
        self.user = try container.decodeIfPresent(UnsplashUser.self, forKey: .user)
        self.links = try container.decodeIfPresent(UnsplashLinks.self, forKey: .links)
        self.shareKey = try container.decodeIfPresent(String.self, forKey: .shareKey)
        self.totalPhotos = try container.decodeIfPresent(Int64.self, forKey: .totalPhotos)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
    }
}
