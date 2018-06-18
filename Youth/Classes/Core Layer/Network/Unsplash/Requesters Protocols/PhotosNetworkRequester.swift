//
//  PhotosNetworkRequester.swift
//  Youth
//
//  Created by Lupu Cristian on 6/1/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

public typealias PhotosResponse = ((UnsplashResult<[UnsplashPhoto], NetworkError>) -> ())

/// Responsible to obtain photos from network
public protocol PhotosNetworkRequester: class {

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


