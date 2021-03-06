//
//  UnsplashLinks.swift
//  Youth
//
//  Created by Cristian Lupu on 4/22/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

extension Unsplash {
    /**
     Struct which contains links
     */
    struct Links: Decodable {
        let `self`: URL?
        let html: URL?
        let download: URL?
        let downloadLocation: URL?
        let photos: URL?
        let likes: URL?
        let portfolio: URL?
        let following: URL?
        let followers: URL?

        private enum CodingKeys: String, CodingKey {
            case `self` = "self"
            case html
            case download
            case downloadLocation = "download_location"
            case photos
            case likes
            case portfolio
            case followers
            case following
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.`self` = try container.decodeIfPresent(URL.self, forKey: .`self`)
            self.html = try container.decodeIfPresent(URL.self, forKey: .html)
            self.download = try container.decodeIfPresent(URL.self, forKey: .download)
            self.downloadLocation = try container.decodeIfPresent(URL.self, forKey: .downloadLocation)
            self.photos = try container.decodeIfPresent(URL.self, forKey: .photos)
            self.likes = try container.decodeIfPresent(URL.self, forKey: .likes)
            self.portfolio = try container.decodeIfPresent(URL.self, forKey: .portfolio)
            self.followers = try container.decodeIfPresent(URL.self, forKey: .followers)
            self.following = try container.decodeIfPresent(URL.self, forKey: .following)
        }
    }
}
