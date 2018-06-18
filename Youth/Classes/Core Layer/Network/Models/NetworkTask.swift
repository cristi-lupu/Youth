//
//  NetworkTask.swift
//  Youth
//
//  Created by Lupu Cristian on 4/30/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Alamofire

public typealias Method = Alamofire.HTTPMethod

/// Task to perform request
public struct Task {

    /// Endpoint URL
    public let endpoint: URL

    /// Method to perform request
    public let method: Method

    /// Parameters
    public let parameters: [String : Any]?

    /// Encoding
    public let encoding: URLEncoding

    /// Headers
    public let headers: [String : String]?

}
