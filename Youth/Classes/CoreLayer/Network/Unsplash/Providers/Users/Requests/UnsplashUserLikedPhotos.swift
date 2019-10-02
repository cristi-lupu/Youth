//
//  UnsplashUserLikedPhotos.swift
//  Youth
//
//  Created by Cristian Lupu on 10/13/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Moya

extension Unsplash {
    struct UserLikedPhotosRequest: UnsplashUsersRequest {
        let username: String
        let pagination: PhotosPagination

        init(username: String, pagination: PhotosPagination) {
            self.username = username
            self.pagination = pagination
        }

        var path: String { return "/" + username + "/likes" }

        var method: Moya.Method { return .get }

        var sampleData: Data { return Data(testResponseFileName: "UnsplashUserLikedPhotosResponse") }

        var task: Moya.Task {
            return .requestParameters(parameters: pagination.parameters, encoding: URLEncoding.queryString)
        }
    }
}
