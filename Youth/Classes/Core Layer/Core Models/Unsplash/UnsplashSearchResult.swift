//
//  UnsplashSearchResult.swift
//  Youth
//
//  Created by Lupu Cristian on 6/2/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

/// Search Result Response. Use for photos and collections.
public struct UnsplashSearchResult<ResultModel: Decodable> {

    /// Total Results
    public let total: Int

    /// Total pages
    public let totalPages: Int

    /// Results
    public let results: [ResultModel]

}

// MARK: Decodable

extension UnsplashSearchResult: Decodable {

    private enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.total = try container.decode(Int.self, forKey: .total)
        self.totalPages = try container.decode(Int.self, forKey: .totalPages)
        self.results = try container.decode([ResultModel].self, forKey: .results)
    }

}
