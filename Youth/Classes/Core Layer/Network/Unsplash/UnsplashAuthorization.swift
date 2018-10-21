//
//  UnsplashAuthorization.swift
//  Youth
//
//  Created by Cristian Lupu on 4/30/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

/**
 Configuration for network client
 */
enum UnsplashAuthorization {
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
    static var `default`: UnsplashAuthorization {
        return UnsplashAuthorization.unauthorizedUser(clientID: UnsplashConstants.clientID)
    }
}
