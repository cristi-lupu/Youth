//
//  UnsplashPhotosRequest.swift
//  Youth
//
//  Created by Cristian Lupu on 10/13/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Moya

extension Unsplash {
    struct PhotosRequest: UnsplashPhotosRequest {
        let pagination: PhotosPagination

        init(pagination: PhotosPagination) {
            self.pagination = pagination
        }

        var path: String { return "" }

        var method: Moya.Method { return .get }

        var sampleData: Data { return Data(testResponseFileName: "UnsplashPhotosResponse") }

        var task: Moya.Task {
            return .requestParameters(parameters: pagination.parameters, encoding: URLEncoding.queryString)
        }
    }
}
