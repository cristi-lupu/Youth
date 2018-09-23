//
//  UserPublicProfileNetworkRequester.swift
//  Youth
//
//  Created by Lupu Cristian on 6/1/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

typealias UserPublicProfileResponse = ((UnsplashResult<UnsplashUser, NetworkError>) -> ())

/// Responsible to obtain user information from network
protocol UserPublicProfileNetworkRequester: class {
    
    /**
     Get user
     
     - parameter username: Username
     - parameter completion: Completion closure
     
     - returns: NetworkRequestCancelable
     */
    @discardableResult
    func userPublicProfile(username: String,
                           completion: @escaping UserPublicProfileResponse) -> NetworkRequestCancelable
    
}
