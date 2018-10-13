//
//  PhotosCollectionUsage.swift
//  Youth
//
//  Created by Cristian Lupu on 5/11/18.
//  Copyright © 2018 Cristian Lupu. All rights reserved.
//

import Foundation

enum PhotosCollectionUsage {
    case photos(orderBy: UnsplashPhotosOrderBy)
    case userPhotos(username: String, orderBy: UnsplashPhotosOrderBy)
    case searchPhotos(query: String)
}
