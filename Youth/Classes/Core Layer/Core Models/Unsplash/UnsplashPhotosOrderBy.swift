//
//  UnsplashPhotosOrderBy.swift
//  Youth
//
//  Created by Lupu Cristian on 4/22/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

/**
 Describe how to sort photos.

 Used for Unsplash API.
 */
public enum UnsplashPhotosOrderBy: String {
    case latest = "latest"
    case oldest = "oldest"
    case popular = "popular"
}
