//
//  UnsplashSearchResult.swift
//  Youth
//
//  Created by Cristian Lupu on 6/2/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

/// Search Result Response. Use for photos and collections.
struct UnsplashSearchResult<ResultModel: Decodable> {
    /// Total Results
    let total: Int

    /// Total pages
    let totalPages: Int

    /// Results
    let results: [ResultModel]
}

// MARK: Decodable

extension UnsplashSearchResult: Decodable {
    private enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.total = try container.decode(Int.self, forKey: .total)
        self.totalPages = try container.decode(Int.self, forKey: .totalPages)
        self.results = try container.decode([ResultModel].self, forKey: .results)
    }
}
