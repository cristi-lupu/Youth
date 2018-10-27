//
//  UnsplashPhotosPagination.swift
//  Youth
//
//  Created by Cristian Lupu on 10/13/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

extension Unsplash {
    struct PhotosPagination: ParametersConvertible {
        let page: Int
        let perPage: Int
        let orderBy: PhotosOrderBy

        var parameters: [String: Any] {
            return ["page": page,
                    "per_page": perPage,
                    "order_by": orderBy.rawValue]
        }
    }
}
