//
//  UnsplashSearchRequestComposer.swift
//  Youth
//
//  Created by Cristian Lupu on 10/13/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Moya

protocol UnsplashSearchRequest: Request { }

extension Unsplash {
    struct SearchRequestComposer: RequestComposer {
        var baseURL: URL {
            return URL(string: Constants.baseURL + "/search")!
        }

        let request: Request

        init(_ request: UnsplashSearchRequest) {
            self.request = request
        }
    }
}
