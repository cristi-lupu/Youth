//
//  UnsplashPhotosRequestComposer.swift
//  Youth
//
//  Created by Cristian Lupu on 10/13/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Moya

protocol UnsplashPhotosRequest: Request { }

extension Unsplash {
    struct PhotosRequestComposer: RequestComposer {
        var baseURL: URL {
            return URL(string: Constants.baseURL + "/photos")!
        }

        let request: Request

        init(_ request: UnsplashPhotosRequest) {
            self.request = request
        }
    }
}
