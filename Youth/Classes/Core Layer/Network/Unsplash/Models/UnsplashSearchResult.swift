//
//  UnsplashSearchResult.swift
//  Youth
//
//  Created by Cristian Lupu on 6/2/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

extension Unsplash {
    /// Search Result Response. Use for photos and collections.
    struct SearchResult<Result: Decodable>: Decodable {
        /// Total Results
        let total: Int

        /// Total pages
        let totalPages: Int

        /// Results
        let results: [Result]

        private enum CodingKeys: String, CodingKey {
            case total
            case totalPages = "total_pages"
            case results
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.total = try container.decode(Int.self, forKey: .total)
            self.totalPages = try container.decode(Int.self, forKey: .totalPages)
            self.results = try container.decode([Result].self, forKey: .results)
        }
    }
}
