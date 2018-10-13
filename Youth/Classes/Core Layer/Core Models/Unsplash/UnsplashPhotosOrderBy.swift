//
//  UnsplashPhotosOrderBy.swift
//  Youth
//
//  Created by Cristian Lupu on 4/22/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

/**
 Describe how to sort photos.
 
 Used for Unsplash API.
 */
enum UnsplashPhotosOrderBy: String {
    case latest = "latest"
    case oldest = "oldest"
    case popular = "popular"
}
