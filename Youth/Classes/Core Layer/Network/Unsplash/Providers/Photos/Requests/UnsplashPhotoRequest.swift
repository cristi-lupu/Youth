//
//  UnsplashPhotoRequest.swift
//  Youth
//
//  Created by Cristian Lupu on 10/13/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Moya

extension Unsplash {
    struct PhotoRequest: UnsplashPhotosRequest {
        let photoID: String
        let size: CGSize?
        let cropRect: CGRect?

        init(photoID: String, size: CGSize? = nil, cropRect: CGRect? = nil) {
            self.photoID = photoID
            self.size = size
            self.cropRect = cropRect
        }

        var path: String { return "/" + photoID }

        var method: Moya.Method { return .get }

        var sampleData: Data { return Data(testResponseFileName: "UnsplashPhotoResponse") }

        var task: Moya.Task {
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }

        var parameters: [String: Any] {
            var params = [String: Any]()

            if let size = size {
                params["w"] = size.width
                params["h"] = size.height
            }

            if let rect = cropRect {
                params["rect"] = "\(rect.origin.x),\(rect.origin.y),\(rect.width),\(rect.height)"
            }

            return params
        }
    }
}
