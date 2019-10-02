//
//  Request.swift
//  Youth
//
//  Created by Cristian Lupu on 9/23/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Moya

protocol Request {
    var path: String { get }
    var method: Moya.Method { get }
    var sampleData: Data { get }
    var task: Moya.Task { get }
    var headers: [String: String]? { get }
}

extension Request {
    var sampleData: Data { return Data() }
    var headers: [String: String]? { return nil }
}
