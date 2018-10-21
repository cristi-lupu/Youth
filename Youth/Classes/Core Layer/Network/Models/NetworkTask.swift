//
//  NetworkTask.swift
//  Youth
//
//  Created by Cristian Lupu on 4/30/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Alamofire

typealias Method = Alamofire.HTTPMethod

/// Task to perform request
struct Task {
    /// Endpoint URL
    let endpoint: URL

    /// Method to perform request
    let method: Method

    /// Parameters
    let parameters: [String: Any]?

    /// Encoding
    let encoding: URLEncoding

    /// Headers
    let headers: [String: String]?
}
