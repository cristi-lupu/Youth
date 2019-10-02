//
//  Unsplash+Response.swift
//  Youth
//
//  Created by Cristian Lupu on 10/13/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Moya

protocol UnsplashResponseType {
    associatedtype Model

    var model: Model { get }
    var statusCode: Int { get }
    var request: URLRequest? { get }
    var response: URLResponse? { get }
}

extension UnsplashResponseType {
    func map<U>(_ transform: (Model) -> U) -> Unsplash.Response<U> {
        return Unsplash.Response<U>(model: transform(model),
                                    statusCode: statusCode,
                                    request: request,
                                    response: response)
    }
}

extension Unsplash {
    struct Response<T>: UnsplashResponseType {
        let model: T
        let statusCode: Int
        let request: URLRequest?
        let response: URLResponse?

        init(model: T, statusCode: Int, request: URLRequest? = nil, response: URLResponse? = nil) {
            self.model = model
            self.statusCode = statusCode
            self.request = request
            self.response = response
        }
    }
}

extension Unsplash.Response where T == Data {
    init(moyaResponse: Moya.Response) {
        self.model = moyaResponse.data
        self.statusCode = moyaResponse.statusCode
        self.request = moyaResponse.request
        self.response = moyaResponse.response
    }
}
