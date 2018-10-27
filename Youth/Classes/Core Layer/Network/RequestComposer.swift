//
//  RequestComposer.swift
//  Youth
//
//  Created by Cristian Lupu on 10/13/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Moya

protocol RequestComposer: TargetType {
    var request: Request { get }
}

extension RequestComposer {
    var path: String { return request.path }
    var method: Moya.Method { return request.method }
    var sampleData: Data { return request.sampleData }
    var task: Moya.Task { return request.task }
    var headers: [String: String]? { return request.headers }
}
