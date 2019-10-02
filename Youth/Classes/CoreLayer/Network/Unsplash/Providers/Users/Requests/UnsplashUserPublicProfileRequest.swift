//
//  UnsplashUserPublicProfileRequest.swift
//  Youth
//
//  Created by Cristian Lupu on 10/13/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Moya

extension Unsplash {
    struct UserPublicProfileRequest: UnsplashUsersRequest {
        let username: String

        init(username: String) {
            self.username = username
        }

        var path: String { return "/" + username }

        var method: Moya.Method { return .get }

        var sampleData: Data { return Data(testResponseFileName: "UnsplashUserPublicProfileResponse") }

        var task: Moya.Task { return .requestPlain }
    }
}
