//
//  UnsplashUser.swift
//  Youth
//
//  Created by Lupu Cristian on 4/22/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

/// User object
public struct UnsplashUser {

    /// Identifier
    public let id: String?

    /// Updated at (date)
    public let updatedAt: Date?

    /// Username
    public let username: String?

    /// First name
    public let firstName: String?

    /// Last name
    public let lastName: String?

    /// Name
    public let name: String?

    /// Instagram username
    public let instagramUsername: String?

    /// Twitter username
    public let twitterUsername: String?

    /// Email
    public let email: String?

    /// Bio
    public let bio: String?

    /// Is followed by user
    public let followedByUser: Bool?

    /// Followers Count
    public let followersCount: Int64?

    /// Following Count
    public let followingCount: Int64?

    /// Downloads Count
    public let downloads: Int64?

    /// Uploads Remaining Count
    public let uploadsRemaining: Int64?

    /// Location
    public let location: String?

    /// Total likes count
    public let totalLikes: Int64?

    /// Total photos count
    public let totalPhotos: Int64?

    /// Total collections count
    public let totalCollections: Int64?

    /// Profile Image
    public let profileImage: UnsplashProfileImage?

    /// Links
    public let links: UnsplashLinks?

    /// Portfolio URL
    public let portfolioURL: URL?

    /// Badge
    public let badge: UnsplashBadge?

}

// MARK: Decodable

extension UnsplashUser: Decodable {

    private enum CodingKeys: String, CodingKey {
        case id
        case updatedAt = "updated_at"
        case username
        case firstName = "first_name"
        case lastName = "last_name"
        case name
        case instagramUsername = "instagram_username"
        case twitterUsername = "twitter_username"
        case email
        case bio
        case followedByUser = "followed_by_user"
        case followersCount = "followers_count"
        case followingCount = "following_count"
        case downloads
        case uploadsRemaining = "uploads_remaining"
        case location
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case totalCollections = "total_collections"
        case profileImage = "profile_image"
        case links
        case portfolioURL = "portfolio_url"
        case badge
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)

        let updatedAtString = try container.decodeIfPresent(String.self, forKey: .updatedAt)
        self.updatedAt = UnsplashDateConverter.date(from: updatedAtString)
        
        self.username = try container.decodeIfPresent(String.self, forKey: .username)
        self.firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        self.lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.instagramUsername = try container.decodeIfPresent(String.self, forKey: .instagramUsername)
        self.twitterUsername = try container.decodeIfPresent(String.self, forKey: .twitterUsername)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.bio = try container.decodeIfPresent(String.self, forKey: .bio)
        self.followedByUser = try container.decodeIfPresent(Bool.self, forKey: .followedByUser)
        self.followersCount = try container.decodeIfPresent(Int64.self, forKey: .followersCount)
        self.followingCount = try container.decodeIfPresent(Int64.self, forKey: .followingCount)
        self.downloads = try container.decodeIfPresent(Int64.self, forKey: .downloads)
        self.uploadsRemaining = try container.decodeIfPresent(Int64.self, forKey: .uploadsRemaining)
        self.location = try container.decodeIfPresent(String.self, forKey: .location)
        self.totalLikes = try container.decodeIfPresent(Int64.self, forKey: .totalLikes)
        self.totalPhotos = try container.decodeIfPresent(Int64.self, forKey: .totalPhotos)
        self.totalCollections = try container.decodeIfPresent(Int64.self, forKey: .totalCollections)
        self.profileImage = try container.decodeIfPresent(UnsplashProfileImage.self, forKey: .profileImage)
        self.links = try container.decodeIfPresent(UnsplashLinks.self, forKey: .links)
        self.portfolioURL = try container.decodeIfPresent(URL.self, forKey: .portfolioURL)
        self.badge = try container.decodeIfPresent(UnsplashBadge.self, forKey: .badge)
    }

}
