//
//  UnsplashAuthorizationPlugin.swift
//  Youth
//
//  Created by Cristian Lupu on 10/14/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Moya

extension Unsplash {
    final class AuthorizationPlugin: PluginType {
        private let authorization: Authorization

        init(authorization: Authorization) {
            self.authorization = authorization
        }

        func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
            var request = request

            request.addValue("v1", forHTTPHeaderField: "Accept-Version")

            switch authorization {
            case let .unauthorizedUser(clientID):
                request.addValue("Client-ID \(clientID)", forHTTPHeaderField: "Authorization")
            case let .authorizedUser(accessToken):
                request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            }

            return request
        }
    }
}
