//
//  UserLikedPhotosNetworkRequester.swift
//  Youth
//
//  Created by Lupu Cristian on 6/1/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

/// Responsible to obtain user liked photos from network
protocol UserLikedPhotosNetworkRequester: class {
    
    /**
     Get user liked photos
     
     - parameter username: Username
     - parameter page: Photos page
     - parameter perPage: Per page
     - parameter orderBy: How to order photos
     - parameter completion: Completion closure
     
     - returns: NetworkRequestCancelable
     */
    @discardableResult
    func userLikedPhotos(username: String,
                         page: Int,
                         perPage: Int,
                         orderBy: UnsplashPhotosOrderBy,
                         completion: @escaping PhotosResponse) -> NetworkRequestCancelable
    
}
