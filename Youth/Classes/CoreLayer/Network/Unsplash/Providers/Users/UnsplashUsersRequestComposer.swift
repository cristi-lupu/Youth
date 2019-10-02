//
//  UnsplashUsersRequestComposer.swift
//  Youth
//
//  Created by Cristian Lupu on 10/13/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Moya

protocol UnsplashUsersRequest: Request { }

extension Unsplash {
    struct UsersRequestComposer: RequestComposer {
        var baseURL: URL {
            return URL(string: Constants.baseURL + "/users")!
        }

        let request: Request

        init(_ request: UnsplashUsersRequest) {
            self.request = request
        }
    }
}
