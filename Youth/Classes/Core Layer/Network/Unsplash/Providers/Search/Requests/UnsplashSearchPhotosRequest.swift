//
//  UnsplashSearchPhotosRequest.swift
//  Youth
//
//  Created by Cristian Lupu on 10/13/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Moya

extension Unsplash {
    struct SearchPhotosRequest: UnsplashSearchRequest {
        let query: String
        let pagination: Pagination

        init(query: String, pagination: Pagination) {
            self.query = query
            self.pagination = pagination
        }

        var path: String { return "/photos" }

        var method: Moya.Method { return .get }

        var sampleData: Data { return Data(testResponseFileName: "UnsplashSearchPhotosResponse") }

        var task: Moya.Task {
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }

        var parameters: [String: Any] {
            var params = pagination.parameters
            params["query"] = query

            return params
        }
    }
}
