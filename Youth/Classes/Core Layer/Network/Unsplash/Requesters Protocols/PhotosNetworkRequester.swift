//
//  PhotosNetworkRequester.swift
//  Youth
//
//  Created by Cristian Lupu on 6/1/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

typealias PhotosResponse = ((UnsplashResult<[UnsplashPhoto], NetworkError>) -> Void)

/// Responsible to obtain photos from network
protocol PhotosNetworkRequester: class {
    /**
     Get photos
     
     - parameter page: Photos page
     - parameter perPage: Per page photos
     - parameter orderBy: How to order photos
     - parameter completion: Completion closure
     
     - returns: NetworkRequestCancelable
     */
    @discardableResult
    func photos(page: Int,
                perPage: Int,
                orderBy: UnsplashPhotosOrderBy,
                completion: @escaping PhotosResponse) -> NetworkRequestCancelable
}
