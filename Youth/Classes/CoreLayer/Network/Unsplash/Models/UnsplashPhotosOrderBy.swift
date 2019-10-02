//
//  UnsplashPhotosOrderBy.swift
//  Youth
//
//  Created by Cristian Lupu on 4/22/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

extension Unsplash {
    /**
     Describe how to sort photos.

     Used for Unsplash API.
     */
    enum PhotosOrderBy: String {
        case latest
        case oldest
        case popular
    }
}
