//
//  PhotoNetworkRequester.swift
//  Youth
//
//  Created by Lupu Cristian on 6/15/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

public typealias PhotoResponse = ((UnsplashResult<UnsplashPhoto, NetworkError>) -> ())

/// Responsible to obtain photo from network
public protocol PhotoNetworkRequester: class {

    /**
     Get photo

     - parameter id: Photo id
     - parameter completion: Completion closure

     - returns: NetworkRequestCancelable
    */
    @discardableResult
    func photo(id: String, completion: @escaping PhotoResponse) -> NetworkRequestCancelable

}
