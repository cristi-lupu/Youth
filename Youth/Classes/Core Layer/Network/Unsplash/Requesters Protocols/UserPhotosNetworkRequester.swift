//
//  UserPhotosNetworkRequester.swift
//  Youth
//
//  Created by Lupu Cristian on 6/1/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

/// Responsible to obtain user photos from network
protocol UserPhotosNetworkRequester: class {
    
    /**
     Get user photos
     
     - parameter username: Username
     - parameter page: Photos page
     - parameter perPage: Per page
     - parameter orderBy: How to order photos
     - parameter includeStats: If need to include stats
     - parameter completion: Completion closure
     
     - returns: NetworkRequestCancelable
     */
    @discardableResult
    func userPhotos(username: String,
                    page: Int,
                    perPage: Int,
                    orderBy: UnsplashPhotosOrderBy,
                    includeStats: Bool,
                    completion: @escaping PhotosResponse) -> NetworkRequestCancelable
    
}
