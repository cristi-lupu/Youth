//
//  PhotosCollectionUsage.swift
//  Youth
//
//  Created by Lupu Cristian on 5/11/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import Foundation

public enum PhotosCollectionUsage {
    case photos(orderBy: UnsplashPhotosOrderBy)
    case userPhotos(username: String, orderBy: UnsplashPhotosOrderBy)
    case searchPhotos(query: String)
}
