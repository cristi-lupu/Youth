//
//  PhotoNetworkRequester.swift
//  Youth
//
//  Created by Cristian Lupu on 6/15/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

typealias PhotoResponse = ((UnsplashResult<UnsplashPhoto, NetworkError>) -> Void)

/// Responsible to obtain photo from network
protocol PhotoNetworkRequester: class {
    /**
     Get photo
     
     - parameter id: Photo id
     - parameter completion: Completion closure
     
     - returns: NetworkRequestCancelable
     */
    @discardableResult
    func photo(id: String, completion: @escaping PhotoResponse) -> NetworkRequestCancelable
}
