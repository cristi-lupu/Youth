//
//  SearchPhotosNetworkRequester.swift
//  Youth
//
//  Created by Lupu Cristian on 6/2/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

typealias SearchPhotosResponse = ((UnsplashResult<UnsplashSearchResult<UnsplashPhoto>, NetworkError>) -> ())

/// Responsible to obtain photos by query from network
protocol SearchPhotosNetworkRequester: class {
    
    /**
     Get photos by query
     
     - parameter query: Query string
     - parameter page: Photos page
     - parameter perPage: Per page
     - parameter completion: Completion closure
     
     - returns: NetworkRequestCancelable
     */
    @discardableResult
    func searchPhotos(query: String,
                      page: Int,
                      perPage: Int,
                      completion: @escaping SearchPhotosResponse) -> NetworkRequestCancelable
    
}
