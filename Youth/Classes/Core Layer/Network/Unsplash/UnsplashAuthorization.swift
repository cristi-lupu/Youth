//
//  UnsplashAuthorization.swift
//  Youth
//
//  Created by Cristian Lupu on 10/14/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

extension Unsplash {
    enum Authorization {
        /**
         Unauthorized User

         - parameter clientID: Valid Client ID.
         */
        case unauthorizedUser(clientID: String)

        /**
         Authorized User

         - parameter accessToken: Valid AccessToken.
         */
        case authorizedUser(accessToken: String)

        /**
         Default configuration. It is the unathorized user with client id from Constants
         */
        static var `default`: Authorization {
            return .unauthorizedUser(clientID: Constants.clientID)
        }
    }
}
