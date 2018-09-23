//
//  UnsplashUser.swift
//  Youth
//
//  Created by Lupu Cristian on 4/22/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

/// User object
struct UnsplashUser {
    
    /// Identifier
    let id: String?
    
    /// Updated at (date)
    let updatedAt: Date?
    
    /// Username
    let username: String?
    
    /// First name
    let firstName: String?
    
    /// Last name
    let lastName: String?
    
    /// Name
    let name: String?
    
    /// Instagram username
    let instagramUsername: String?
    
    /// Twitter username
    let twitterUsername: String?
    
    /// Email
    let email: String?
    
    /// Bio
    let bio: String?
    
    /// Is followed by user
    let followedByUser: Bool?
    
    /// Followers Count
    let followersCount: Int64?
    
    /// Following Count
    let followingCount: Int64?
    
    /// Downloads Count
    let downloads: Int64?
    
    /// Uploads Remaining Count
    let uploadsRemaining: Int64?
    
    /// Location
    let location: String?
    
    /// Total likes count
    let totalLikes: Int64?
    
    /// Total photos count
    let totalPhotos: Int64?
    
    /// Total collections count
    let totalCollections: Int64?
    
    /// Profile Image
    let profileImage: UnsplashProfileImage?
    
    /// Links
    let links: UnsplashLinks?
    
    /// Portfolio URL
    let portfolioURL: URL?
    
    /// Badge
    let badge: UnsplashBadge?
    
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
    
    init(from decoder: Decoder) throws {
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
