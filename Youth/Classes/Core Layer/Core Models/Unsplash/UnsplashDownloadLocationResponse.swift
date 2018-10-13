//
//  UnsplashDownloadLocationResponse.swift
//  Youth
//
//  Created by Cristian Lupu on 6/17/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

// To download images from Unplash API, need to create request to dowload_location property of image.
// And then extract download url from response.

/// Dowload location response
struct UnsplashDownloadLocationResponse {
    
    let url: URL?
    
}

// MARK: Decodable

extension UnsplashDownloadLocationResponse: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try container.decodeIfPresent(URL.self, forKey: .url)
    }
    
}
